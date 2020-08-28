import mysql.connector
import pandas as pd
import datetime
from beem import Steem
from beem.account import Account
import datetime
import time
import os
import json

class DatetimeEncoder(json.JSONEncoder):
        def default(self, obj):
            try:
                return super(DatetimeEncoder, obj).default(obj)
            except TypeError:
                return str(obj)

def script():
    if os.path.isfile("data.json"):
        last_details = json.load(open('data.json'))
        last_details['last_timestamp'] = pd.to_datetime(last_details['last_timestamp'])
    else:
        last_details = {}
        last_details['last_timestamp'] = datetime.datetime(2020, 6, 20)
        with open('data.json', 'w') as f:
            json.dump(last_details, f, cls=DatetimeEncoder)

    steem = Steem(node=['https://api.steemit.com', 'https://anyx.io', 'https://api.steem.house', 'https://5.9.18.213:2001', 'https://lafonasteem.com:2001', 'https://seed.rossco99.com:2001', 'https://176.31.126.187:2001', 'https://steem-seed.lukestokes.info:2001', 'https://steemseed-se.privex.io:2001', 'https://seed.steemmonsters.com:2001'])
    account = Account('steem-keeper', steem_instance=steem)

    while True:
        try:
            mydb = mysql.connector.connect(
            host="localhost",
            user="opnmarket_user",
            password="@dminP@ssword",
            database="opnmarket"
            )

            ## PLAN EXPIRITY ##
            mycursor = mydb.cursor()
            mycursor.execute("SELECT s.id, s.user_id, s.status, u.date FROM user_subscriptions s LEFT JOIN users u ON u.id = s.user_id")
            myresult = mycursor.fetchall()
            df = pd.DataFrame(myresult, columns=['id', 'user_id', 'status', 'date'])

            for idx,row in df.iterrows():
                if row['status'] == 1:
                    if row['date']<datetime.datetime.now().date():
                        mycursor.execute("UPDATE user_subscriptions SET status=0 WHERE id={}".format(row['id']))
                        mydb.commit()
            ## PLAN EXPIRITY ##



            ## ORDER EXPIRITY ##
            expire_from = pd.to_datetime(time.time(), unit='s') - pd.Timedelta(minutes=30)

            expire_before = expire_from.to_pydatetime().strftime("%Y-%m-%d %H:%M:%S")

            mycursor.execute("SELECT id FROM orders WHERE created_at<'{}' AND expired=0 AND payment_status!='Completed'".format(expire_before))
            myresult = mycursor.fetchall()

            for res in myresult:
                mycursor.execute("DELETE FROM vendor_orders WHERE order_id={}".format(res[0]))
                mycursor.execute("UPDATE orders SET expired=1 WHERE id={}".format(res[0]))
                mydb.commit()

            ## ORDER EXPIRITY ##

            last_details = json.load(open('data.json'))
            last_details['last_timestamp'] = pd.to_datetime(last_details['last_timestamp'])
            
            for h in account.history(start=last_details['last_timestamp']):
                last_details['last_timestamp']= pd.to_datetime(h['timestamp'])
                

                with open('data.json', 'w') as f:
                    json.dump(last_details, f, cls=DatetimeEncoder)
                
                if h['type'] == 'transfer':
                    if h['amount']['nai'] == "@@000000021":
                        memo = h['memo']
                        amount = str(float(h['amount']['amount'])/1000)

                        print("Got a transaction")

                        ## SUBSCRIPTION PAYMENT ##
                        mycursor = mydb.cursor()

                        #Make half payment work. Check amount
                        mycursor.execute("SELECT id, user_id, subscription_id, paid, memo, shop_name, shop_message, updated_at, created_at FROM subscription_payments WHERE memo='{}' AND paid=0".format(memo))
                        myresult = mycursor.fetchall()
                        
                        if len(myresult) > 0:
                            subscription_payments_id = myresult[0][0]

                            #Set payment as Completed
                            sql = "UPDATE subscription_payments SET paid = 1 WHERE id = '{}'".format(subscription_payments_id)
                            mycursor.execute(sql)
                            mydb.commit()

                            mycursor = mydb.cursor(buffered=True)

                            mycursor.execute("SELECT id, user_id, subscription_id, paid, memo, shop_name, shop_message, updated_at, created_at FROM subscription_payments WHERE id='{}'".format(subscription_payments_id))
                            myresult = mycursor.fetchall()

                            subscription_payments_id = myresult[0][0]
                            user_id = myresult[0][1]
                            subscription_id = myresult[0][2]
                            paid = myresult[0][3]
                            memo = myresult[0][4]
                            shop_name = myresult[0][5]
                            shop_message = myresult[0][6]

                            mycursor.execute("SELECT id, title, currency, currency_code, price, days, allowed_products, details FROM subscriptions WHERE id='{}'".format(subscription_id))
                            myresult = mycursor.fetchall()

                            subscription_id = myresult[0][0]
                            title = myresult[0][1]
                            currency = myresult[0][2]
                            currency_code = myresult[0][3]
                            price = myresult[0][4]
                            days = myresult[0][5]
                            allowed_products = myresult[0][6]
                            details = myresult[0][7]

                            mycursor.execute("SELECT date FROM users WHERE id='{}'".format(user_id))
                            myresult = mycursor.fetchall()
                            expirity_date = myresult[0][0]

                            if expirity_date == None:
                                date = datetime.datetime.now()
                            else:
                                date = expirity_date

                            expirity_date =date + datetime.timedelta(days=days)

                            mycursor.execute("UPDATE users SET shop_name=%s, shop_message=%s, date=%s WHERE id=%s",(shop_name, shop_message, expirity_date, user_id))
                            mydb.commit()

                            #If already exist, remove before inserting
                            mycursor.execute("DELETE FROM user_subscriptions WHERE user_id={}".format(user_id)) 
                            mydb.commit()

                            mycursor.execute("INSERT INTO user_subscriptions(user_id, subscription_id, title, currency, currency_code, price, days, allowed_products, details, method, status, created_at, updated_at) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", 
                                            (user_id, subscription_id, title, currency, currency_code, price, days, allowed_products, details, "Paid", 1, datetime.datetime.now(), datetime.datetime.now()))
                            mydb.commit()

                            message = "Payment has been received. You are now a premium user for {} days".format(days)

                            #Create conversation
                            sql = "INSERT INTO conversations(subject, sent_user, recieved_user, message, created_at, updated_at) VALUES ('{}', '{}', '{}', '{}', '{}', '{}')".format("Payment Received", user_id, user_id, message, datetime.datetime.now(), datetime.datetime.now())
                            mycursor.execute(sql)
                            mydb.commit()

                            conversation_id = mycursor.lastrowid

                            #Create message
                            sql = "INSERT INTO messages(conversation_id, message, sent_user, created_at, updated_at) VALUES ('{}', '{}', '{}', '{}', '{}')".format(conversation_id, message, user_id, datetime.datetime.now(), datetime.datetime.now())
                            mycursor.execute(sql)
                            mydb.commit()

                            #Send user notification to message
                            sql = "INSERT INTO notifications(user_id, conversation_id, type, created_at, updated_at) VALUES ('{}', '{}', 'user','{}', '{}')".format(user_id, conversation_id, datetime.datetime.now(), datetime.datetime.now())
                            mycursor.execute(sql)
                            mydb.commit()
                        ## SUBSCRIPTION PAYMENT ##


                        ## ORDER PAYMENT ##
                        mycursor = mydb.cursor()

                        mycursor.execute("SELECT id, user_id, vendor_id, pay_amount, order_number FROM orders WHERE payment_status='Pending' AND order_number='{}' AND expired=0".format(memo))
                        myresult = mycursor.fetchall()
                        
                        if len(myresult) > 0:
                            print("Found order")
                            order_id = myresult[0][-1]
                            paid_amount = myresult[0][-2]

                            if float(paid_amount) >= float(amount):
                                print("Setting as paid")
                                #Set payment as Completed
                                sql = "UPDATE orders SET payment_status = 'Completed' WHERE order_number = '{}'".format(order_id)
                                mycursor.execute(sql)
                                mydb.commit()

                                mycursor = mydb.cursor(buffered=True)

                                mycursor.execute("SELECT id, user_id, vendor_id, pay_amount, order_number FROM orders WHERE order_number='{}'".format(order_id))
                                myresult = mycursor.fetchall()

                                order_id = myresult[0][0]
                                user_id = myresult[0][1]
                                vendor_id = myresult[0][2]
                                pay_amount = myresult[0][3]
                                order_number = myresult[0][4]

                                # #Send vendor notification for order
                                # sql = "INSERT INTO user_notifications(user_id, order_number, created_at, updated_at) VALUES ('{}', '{}', '{}', '{}')".format(user_id, order_number, datetime.datetime.now(), datetime.datetime.now())
                                # mycursor.execute(sql)
                                # mydb.commit()

                                #not like that
                                sql = "INSERT INTO notifications(vendor_id, order_id, type, created_at, updated_at) VALUES ('{}', '{}', 'vendor', '{}', '{}')".format(vendor_id, order_id, datetime.datetime.now(), datetime.datetime.now())
                                mycursor.execute(sql)
                                mydb.commit()

                                #Create conversation
                                sql = "INSERT INTO conversations(subject, sent_user, recieved_user, message, created_at, updated_at) VALUES ('{}', '{}', '{}', '{}', '{}', '{}')".format(order_number, user_id, vendor_id, "Order #{} has been paid".format(order_number), datetime.datetime.now(), datetime.datetime.now())
                                mycursor.execute(sql)
                                mydb.commit()

                                conversation_id = mycursor.lastrowid

                                #Create message
                                sql = "INSERT INTO messages(conversation_id, message, sent_user, created_at, updated_at) VALUES ('{}', '{}', '{}', '{}', '{}')".format(conversation_id, "Order " + order_number + " has been paid. This message is for discussing the order", 0, datetime.datetime.now(), datetime.datetime.now())
                                mycursor.execute(sql)
                                mydb.commit()

                                #Send user notification to message
                                sql = "INSERT INTO notifications(user_id, conversation_id, type, created_at, updated_at) VALUES ('{}', '{}', 'user','{}', '{}')".format(user_id, conversation_id, datetime.datetime.now(), datetime.datetime.now())
                                mycursor.execute(sql)
                                mydb.commit()

                        ## ORDER PAYMENT ##
        except:
            pass

        time.sleep(1)
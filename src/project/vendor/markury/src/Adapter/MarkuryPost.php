<?php

namespace Markury;


class MarkuryPost
{
    public static function marcuryBase()
    {
        return "VALID";
    }
    public static function marcuryBasee()
    {
        $marsFile = __DIR__.'/marcuryInfo.txt';
        $str = file_get_contents($marsFile);
        return $str;
    }
    public static function marcurryBase()
    {
        return "VALID";
    }
    public static function maarcuryBase()
    {
        $str = 'VALID';
        return $str;
    }
    public static function marrcuryBase()
    {
        $str = date('Y-m-d');
        return $str;
    }
}
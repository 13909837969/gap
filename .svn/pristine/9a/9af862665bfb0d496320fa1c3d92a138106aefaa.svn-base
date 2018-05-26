package com.ehtsoft.supervise.utils;

import java.text.NumberFormat;

import com.ehtsoft.im.protocol.Location;

public class GisUtil {

    public static double getDistance(Location loc1,Location loc2){
    	double lat1 = loc1.getLat();
    	double lng1 = loc1.getLng();
    	
    	double lat2 = loc2.getLat();
    	double lng2 = loc2.getLng();
    	
        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);
        double a = radLat1 - radLat2;
        double  b = rad(lng1) - rad(lng2);

        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) +
                Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));
        //EARTH_RADIUS;
        s = s * 6378.137 ;
        //单位：千米
        s = Math.round(s * 10000)*1.0 / 10000;
        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(5);
        return s * 1000; //单位：米
    }
    
    /**
     * 弧度 = 2 * PI * 度数/360
     * @param d
     * @return
     */
    public static double rad(double d)
    {
        return d * Math.PI / 180.0;
    }

}

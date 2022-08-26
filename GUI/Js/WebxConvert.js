/***************************************************************************************************************
AUTHOR      :   KUMAR LACHHANI
FILE NAME   :   WebxConvert.js
VERSION     :   1.0
PURPOSE     :   Common Conversion functions
PROJECT     :   Webx 8.3
***************************************************************************************************************/

var WebxConvert = {

    objectToInt: function (obj, valueifNull) {
        //alert('Start');
        try {

            if (obj != null && obj != "" && obj != undefined) {
                // alert('Start1');
                return parseInt(obj);

            }
            else {
                return valueifNull;
            }
        }
        catch (err) {
            return valueifNull;
        }
    },
    objectToDecimal: function (s, valueifNull) {
        try {
            if ((s != null) && (s.toString().trim() != '') && (s != undefined)) {
                var t = parseFloat(s);
                return t;
            }
            else {
                return valueifNull;
            }
        }
        catch (err) {
            return valueifNull;
        }
    },


    IsStringNullOrEmpty: function (obj) {
        try {

            if (obj != null && obj != '' && obj != undefined && obj.toString().trim() != '') {
                return false;

            }
            else {
                return true;
            }
        }
        catch (err) {
            return true;
        }
    },

    //Created By Kumar Lachhani
    //15th October 2011
    IsObjectNullOrEmpty: function (obj) {
        try {

            if ((obj != undefined) && (obj != null) && (obj.toString().trim() != '')) {
                return false;
            }
            else {
                return true;
            }
        }
        catch (err) {
            return true;
        }
    },

    //Created By Kumar Lachhani
    //10th November 2011
    IsObjectUndefined: function (obj) {
        try {
            //alert('obj ' + obj);
            if (typeof obj === 'undefined') {
                return true;
            }
            else {
                return false;
            }
        }
        catch (err) {
            return true;
        }
    },


    objectToString: function (obj, valueifNull) {
        try {
            if (obj != null && obj != "" && obj != undefined) {
                return obj.toString();
            }
            else {
                return valueifNull;
            }
        }
        catch (err) {
            return valueifNull;
        }
    },

    objectToJSON: function (obj, valueifNull) {
        try {
            if (obj != null && obj != "" && obj != undefined) {

                var jsonDataParsed = $.parseJSON(obj);
                return jsonDataParsed;
            }
            else {
                return valueifNull;
            }
        }
        catch (err) {
            return valueifNull;
        }
    },

    //Created By Vijay Patel
    //26th November 2014
    IsObjectUndefinedOrNull: function (obj) {
        try {
            if (typeof obj === 'undefined' || obj == undefined || obj == null) {
                return true;
            }
            else {
                return false;
            }
        }
        catch (err) {
            return true;
        }
    }
};
 
   


/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
						ViewPrint.js
			This file contains general function for client validation while viewing and printing
			various octroi bills
		
			Applicable to Following Bills
			Customer Bill
			Agent Bill
			Voucher Bill
			Manual MR Bill

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/

 //function validates dateStr and str is only string to display control name

function isValidDate(dateStr,str) 
    {
        var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/; // requires 4 digit year
        var matchArray = dateStr.match(datePat); // is the format ok?
        if (matchArray == null) 
            {
                alert("Please Enter " + str + " Date in dd/mm/yyyy Format");
                return false;
            }

            month = matchArray[3]; // parse date into variables
            day = matchArray[1];
            year = matchArray[4];


        if (month < 1 || month > 12) { // check month range
                alert("In " + str + "Date Month must be between 1 and 12.");
                return false;
            }

        if (day < 1 || day > 31) {
            alert("In " + str + "Day must be between 1 and 31.");
            return false;
            }
    
        if ((month==4 || month==6 || month==9 || month==11) && day==31) {
            alert("In " + str + "Month "+month+" doesn't have 31 days!")
            return false
            }
            
        if (month == 2) { // check for february 29th
            var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
            
            if (day>29 || (day==29 && !isleap)) {
                alert("In " + str + "February " + year + " doesn't have " + day + " days!");
                return false;
                }
            }
    return true; // date is valid
}


// JScript File

function valid(obj,dlstCompany,txtProjectName,dlstProjectWoner,StartDate,End_Date)
{       
    var dt =StartDate.value			
    var dt_dd=dt.substring(0,2)	
    var dt_mm=dt.substring(3,5)
    var dt_yy=dt.substring(6,10)

    var Start_Date=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))

    var dt1 =End_Date.value			
    var dt_dd1=dt1.substring(0,2)	
    var dt_mm1=dt1.substring(3,5)
    var dt_yy1=dt1.substring(6,10)

    var End_Date_D=new Date(months[parseFloat(dt_mm1)] + " " + parseFloat(dt_dd1) + ", " + parseFloat(dt_yy1))
        
    if (dlstCompany.value == "")
    {
        alert("Please Select Valid Company !!");
        dlstCompany.focus();
        return false;
    }
    else if(txtProjectName.value == "")
    {
        alert("Please Enter Project Name !!");
        txtProjectName.focus();
        return false;
    }
    else if(StartDate.value == "")
    {
        alert("Please Enter Start Date !!");
        StartDate.focus();
        return false;
    }
    else if(End_Date.value == "")
    {
        alert("Please Enter End Date !!");
        End_Date.focus();
        return false;
    }
    else if (Start_Date > End_Date_D)
    {
        alert('Start Date can not be less than Target End Date');
        return false;
    }
    else if(dlstProjectWoner.value == "")
    {
        alert("Please Select Project Owner !!");
        End_Date.focus();
        return false;
    }
    else
    {
        return true;
    }
}

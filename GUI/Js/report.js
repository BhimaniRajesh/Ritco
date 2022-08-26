// JScript File

function valid(obj,chk,dlstCustomer,dlstEmployee,status)
    {
        if (chk.value == "1")
        {
            if (document.getElementById('ctl00_MyCPH1_txtDateFrom_txt_Date').value == "" || document.getElementById('ctl00_MyCPH1_txtDateTo_txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
        }
       if (dlstCustomer.value == "")
       {
            alert("Please Select Customer !!");
            return false;
       }
       else if(status.value == "")
       {
            alert("Select Status !!");
            return false;
       }
       else if(dlstEmployee)
       {
            if(dlstEmployee.value == "")
            { 
              alert("Please Select Employee !!");
              return false;
            }
       }
       else if(txtPendingTime)
       {
           if(txtPendingTime.value != "")
           {
                if(isNaN(txtPendingTime.value))
                {
                    alert("Enter Valid Number !!");
                    return false;
                }
           }
       }
    }
    function CHK1(ClientId)
      {
        var idid = ClientId.value;
        document.getElementById('ctl00_MyCPH1_chk').value = ""
        if (idid == "redFromTo")
        {
            document.getElementById('ctl00_MyCPH1_chk').value = "1";
        }
        else
        {
            document.getElementById('ctl00_MyCPH1_chk').value = "0";
        }
        
      }

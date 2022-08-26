<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RouteMasterEdit.aspx.cs" Inherits="GUI_admin_RouteMaster_RouteMaster"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
 function trimAll(strValue) 
        {
            //Trimming left most white space characters
            while (strValue.substring(0,1) == ' ')
            {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length-1, strValue.length) == ' ')
            {
                strValue = strValue.substring(0, strValue.length-1);
            }
            
            return strValue;
        }
function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function footertotal()
        {
            
            if ((hourflag==true) || (minuteflag==true))
            {
                //chkflag=false
                var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
                var footerrow = rows +1
                rows = rows-1
                if (footerrow<10)
                {
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtthtotal").value=0
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txttmtotal").value=0
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtshtotal").value=0
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtsmtotal").value=0
                }
                else
                {
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtthtotal").value=0
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txttmtotal").value=0
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtshtotal").value=0
                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtsmtotal").value=0
                }
           
                for(i=0;i<rows-3;i++)
                {
                    j=i+5
                    if (j<10)
                    {
                        //ctl00$MyCPH1$GrdPaidFollow$ctl05$ChkSelect
                        if (j==5)
                        {
                            continue
                        }
    //                    if (!isNaN(document.getElementById("ctl00$MyCPH1$txtDist").value))
    //                    {
                        //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_ChkSelect").checked == true)
                        //{
                            if (footerrow<10)
                            {
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtthtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtthtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtttimehr").value)
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txttmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txttmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtttimemn").value)
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtshtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtshtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtstimehr").value)
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtsmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtsmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtstimemn").value)                            
                            }
                            else
                            {
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtthtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtthtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtttimehr").value)
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txttmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txttmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtttimemn").value)
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtshtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtshtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtstimehr").value)
                                document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtsmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtsmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtstimemn").value) 
                            }
                        //}
                    //}    
                    }
                    else
                    {
//                        if (!isNaN(document.getElementById("ctl00$MyCPH1$txtDist").value))
    //                    {
                            //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_ChkSelect").checked == true)
                            //{
                                if (footerrow<10)
                                {
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtthtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtthtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtttimehr").value)
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txttmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txttmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtttimemn").value)
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtshtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtshtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtstimehr").value)
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtsmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+footerrow+"_txtsmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtstimemn").value) 
                                }
                                else
                                {
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtthtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtthtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtttimehr").value)
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txttmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txttmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtttimemn").value)
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtshtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtshtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtstimehr").value)
                                    document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtsmtotal").value = Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+footerrow+"_txtsmtotal").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtstimemn").value) 
                                }    
                            //}
                    //}
                    }
                }
             }        
        }
        function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function distancetotal(obj1,obj2)
        {
            if (obj1.checked == true)
            {
                if (obj2.value!="")
                {
                   document.getElementById("ctl00$MyCPH1$txtDist").value = Number(document.getElementById("ctl00$MyCPH1$txtDist").value)+Number(obj2.value)
                   document.getElementById("ctl00$MyCPH1$hiddentxtdist").value = document.getElementById("ctl00$MyCPH1$txtDist").value
                }
            }
            else if (obj1.checked == false)
            {
                if (obj2.value!="")
                {
                    document.getElementById("ctl00$MyCPH1$txtDist").value = Number(document.getElementById("ctl00$MyCPH1$txtDist").value)-Number(obj2.value)
                    document.getElementById("ctl00$MyCPH1$hiddentxtdist").value = document.getElementById("ctl00$MyCPH1$txtDist").value
                }
            }
        }
        function totalkm()
        {
            var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
            rows = rows-1
            document.getElementById("ctl00$MyCPH1$txtDist").value = 0
            for(i=0;i<rows-3;i++)
            {
                j=i+5
                if (j<10)
                {
                    //ctl00$MyCPH1$GrdPaidFollow$ctl05$ChkSelect
                    if (j==5)
                    {
                        continue
                    }
                    if (!isNaN(document.getElementById("ctl00$MyCPH1$txtDist").value))
                    {
                        //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_ChkSelect").checked == true)
                        //{
                            document.getElementById("ctl00$MyCPH1$txtDist").value = Number(document.getElementById("ctl00$MyCPH1$txtDist").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtdistance").value)
                            document.getElementById("ctl00$MyCPH1$hiddentxtdist").value = document.getElementById("ctl00$MyCPH1$txtDist").value
                            //ctl00$MyCPH1$GrdPaidFollow$ctl05$txtdistance  
                        //}
                    }    
                }
                else
                {
                    if (!isNaN(document.getElementById("ctl00$MyCPH1$txtDist").value))
                    {
                        //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_ChkSelect").checked == true)
                        //{
                            document.getElementById("ctl00$MyCPH1$txtDist").value = Number(document.getElementById("ctl00$MyCPH1$txtDist").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtdistance").value)                        
                            document.getElementById("ctl00$MyCPH1$hiddentxtdist").value = document.getElementById("ctl00$MyCPH1$txtDist").value
                        //}
                    }
                }
           }     
        }
        function totalhour()
        {
            chkflag=true
            var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
            rows = rows-1
            document.getElementById("ctl00$MyCPH1$txttransithrs").value = 0
            for(i=0;i<rows-3;i++)
            {
                j=i+5
                if (j<10)
                {
                    //ctl00$MyCPH1$GrdPaidFollow$ctl05$ChkSelect
                    if (j==5)
                    {
                        continue
                    }
                    if (!isNaN(document.getElementById("ctl00$MyCPH1$txttransithrs").value))
                    {
                        //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_ChkSelect").checked == true)
                        //{
                            document.getElementById("ctl00$MyCPH1$txttransithrs").value = Number(document.getElementById("ctl00$MyCPH1$txttransithrs").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtttimehr").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtstimehr").value)+(Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtttimemn").value))/60 +(Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtstimemn").value))/60 
                            //document.getElementById("ctl00$MyCPH1$hiddentxtdist").value = document.getElementById("ctl00$MyCPH1$txtDist").value
                            //ctl00$MyCPH1$GrdPaidFollow$ctl05$txtdistance  
                        //}
                    }    
                }
                else
                {
                    if (!isNaN(document.getElementById("ctl00$MyCPH1$txttransithrs").value))
                    {
                        //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_ChkSelect").checked == true)
                        //{
                            document.getElementById("ctl00$MyCPH1$txttransithrs").value = Number(document.getElementById("ctl00$MyCPH1$txttransithrs").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtttimehr").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtstimehr").value)+(Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtttimemn").value))/60 +(Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtstimemn").value))/60 
                            //document.getElementById("ctl00$MyCPH1$txttransithrs").value = Number(document.getElementById("ctl00$MyCPH1$txtDist").value)+Number(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtdistance").value)                        
                            //document.getElementById("ctl00$MyCPH1$hiddentxtdist").value = document.getElementById("ctl00$MyCPH1$txtDist").value
                        //}
                    }
                }
           }     
        }
        var fcheck
        function fieldcheck()
        {
            fcheck=true
            if (document.getElementById("ctl00$MyCPH1$txtSchHH").value=="")
            {
                alert("Please enter valid Hour")
                document.getElementById("ctl00$MyCPH1$txtSchHH").focus()
                fcheck=false
                return false
            }
            if (document.getElementById("ctl00$MyCPH1$txtSchMM").value=="")
            {
                alert("Please enter valid Minutes")
                document.getElementById("ctl00$MyCPH1$txtSchMM").focus()
                fcheck=false
                return false
            }
            if (document.getElementById("ctl00$MyCPH1$txtStandRate").value=="")
            {
                alert("Please enter valid Standard Rate")
                document.getElementById("ctl00$MyCPH1$txtStandRate").focus()
                fcheck=false
                return false
            }
            else
            {
                //alert ("Returned True")
               fcheck=true
               document.getElementById("ctl00$MyCPH1$txtDist").disabled = false;
               document.getElementById("ctl00$MyCPH1$txttransithrs").disabled = false;
               return true
            }
            
        }
        function checkduplicate(obj)
        {      
            var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
            rows = rows-1
            for(i=0;i<rows-3;i++)
            {
                j=i+5
                if (j<10)
                {
                        if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_ChkSelect").checked == true && obj.id != "ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtbranchname")
                        {
                           if(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtbranchname").value == obj.value && document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtbranchname").value != "")
                           {
                                alert("branch name already exists !!")  
                                obj.focus()  
                                return false
                           }  
                        }
                        
                }
                else
                {
                    if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_ChkSelect").checked == true && obj.id != "ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtbranchname")
                        {
                           if(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtbranchname").value == obj.value && document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtbranchname").value != "")
                           {
                                alert("branch name already exists !!")    
                                obj.focus()  
                                return false
                           }  
                        }
                }
           }     
        }
       function checkbranch()
        {
            var count = 0;
            var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
            rows = rows-1
            for(i=0;i<rows-3;i++)
            {
                j=i+5
                if (j<10)
                {
                    //ctl00$MyCPH1$GrdPaidFollow$ctl05$ChkSelect
                    if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_ChkSelect").checked == true)
                    {
                        if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtbranchname").value == "")
                        {
                            
                            alert("Branch Name Should Not Remain Blank !!")
                            document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtbranchname").focus()
                            return false;
                        }
                        count+=1
                    }
                }
                else
                {
                    if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_ChkSelect").checked == true)
                    {
                        if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtbranchname").value == "")
                        {
                            alert("Branch Name Should Not Remain Blank !!")
                            document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtbranchname").focus()
                            return false;
                        }
                        count+=1
                    }
                }
                
            }
            if (count < 2)
            {
                alert("Please Select Minimum 2 branches !!")
                return false;
            }
            else
            {
                return true;
            }
             
        }
       function checklocation(obj)
       {
       if (obj.value != "")
       {
       obj.value = trimAll(obj.value)
       var a;
       a=1;
       obj.value = obj.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {

            if(obj.value==str[i])
            {
                a=2
                break;
                //return false;
            }
            else
            {
                continue
            }
       }
       if (a!=2)
       {
          alert("please enter valid location")
          obj.focus();
       }
       }
       }
       
       
       
       
       function checklocationsubmit(str1)
       {
            if (fcheck == true)
            {
                if (document.getElementById(str1).value != "")
                {
                    document.getElementById(str1).value = trimAll(document.getElementById(str1).value)
                    var a;
                    a=1;
                    document.getElementById(str1).value = document.getElementById(str1).value.toUpperCase()
                    //alert(str)
                    for(i=0;i<str.length;i++)
                    {

                        if(document.getElementById(str1).value==str[i])
                        {
                            a=2
                            break;
                            //return false;
                        }
                        else
                        {
                            continue
                        }
                    }
       //debugger
                    if (a!=2)
                    {
          //alert("please enter valid location")
                        document.getElementById(str1).focus();
                        return false
                    }
                }
            }
            else
            {
                return false
            }
       }
       
        function Nagative_Chk_wDecimal(obj)
        {
            //alert(obj)
            var a = obj.value 
	       
	        if (a == "")	
	        {
		        return true;
	        }
        	
	        if(isNaN(a))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        return false;
	        } 				
        		  
	        if(parseFloat(a) < 0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        return false;
	        }
        	
	        return true;					   
        }
        
        var hourflag=true
        var minuteflag=true 
        function checkminute(obj)
        {
            //alert(obj)
            var a = obj.value
            hourflag=false 
	        //var temp = trimAll(a) 
        	//alert("Hiiiiiiiiii")
	        if (a == "")	
	        {
	            minuteflag=false
		        return true;
	        }
        	
	        if(isNaN(a))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        minuteflag=false
		        return false;
	        } 				
        		  
	        if(parseFloat(a) < 0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        minuteflag=false
		        return false;
	        }
        	
        	if(Number(obj.value) > 60)
        	{
        	    alert("Please Enter Valid Minutes")
		        obj.focus();
		        minuteflag=false
		        return false;
        	}
        	minuteflag=true
	        return true;					   
        }
              
        function checkhour(obj)
        {
            //alert(obj)
            var a = obj.value
            minuteflag=false
	        //var temp = trimAll(a) 
        	//alert("Hiiiiiiiiii")
	        if (a == "")	
	        {
	            hourflag=false
		        return true;
	        }
        	
	        if(isNaN(a))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        hourflag=false
		        return false;
	        } 				
        		  
	        if(parseFloat(a) < 0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        hourflag=false
		        return false;
	        }
//        	if (Number(obj.value) > 24)
//        	{
//        	    alert("Please Enter Valid Hour")
//		        obj.focus();
//		        hourflag=false
//		        return false;
//        	}
        	hourflag=true
	        return true;					   
        }
    </script>

    <div align="left">
        <table class="boxbg" border="1" cellpadding="0" cellspacing="0">
            <tr bgcolor="white">
                <td height="30" style="width: 459px">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Administrator</b></font></a> <b>&gt; </b><a href="../operations.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Route Master</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="2" align="right" style="height: 35px">
                    <a href="javascript:window.history.go(-1)" title="back"></a>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="2" bgcolor="#FFFFFF">
                    <table class="boxbg" border="" cellpadding="3" cellspacing="0">
                        <tr>
                        <tr class="bgbluegrey" bgcolor="#FFFFFF">
                            <td align="center" colspan="6">
                                <font class="blackfnt"><b>Route Master Header</b></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td bgcolor="#FFFFFF" align="left" style="width: 221px">
                                <font class="blackfnt">Route Code :</font>
                            </td>
                            <td bgcolor="#FFFFFF" align="left">
                                <%--<font class="blackfnt" color="#FF0000" size="2">&lt;System Generated..&gt;</font>--%>
                                <asp:Label ID="lblRutCd" runat="server" ForeColor="red" Text="&ltSystem Generated..&gt"
                                    class="blackfnt"></asp:Label></td>
                            <td bgcolor="#FFFFFF" align="left">
                                <font class="blackfnt">Route Mode :</font>
                            </td>
                            <td bgcolor="#FFFFFF" align="left">
                                <asp:DropDownList ID="ddRouteMode" Enabled="false" runat="server">
                                    <asp:ListItem Value="S">Road</asp:ListItem>
                                    <asp:ListItem Value="R">Rail</asp:ListItem>
                                    <asp:ListItem Value="A">Air</asp:ListItem>
                                </asp:DropDownList></td>
                            <td bgcolor="#FFFFFF" align="left">
                                <font class="blackfnt">Route Category :</font>
                                <asp:DropDownList ID="ddRouteCategory" Enabled="false" runat="server">
                                    <asp:ListItem Value="L">Long Haul</asp:ListItem>
                                    <asp:ListItem Value="S">Short Haul</asp:ListItem>
                                </asp:DropDownList></td>
                            <%--<td style="width: 93px; height: 24px;">
                                                        </td>--%>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left" valign="top" style="width: 221px">
                                <font class="blackfnt">Dist.(Km) / Transit(Hrs.) :</font>
                            </td>
                            <td align="left" valign="top" style="width: 201px">
                                <asp:TextBox ID="txtDist" ReadOnly="false" Text="0" runat="server" Width="66px"></asp:TextBox>
                                /
                                <asp:TextBox ID="txttransithrs" runat="server" ReadOnly="false" Text="0" Width="66px"></asp:TextBox>
                                <asp:HiddenField ID="hiddentxtdist" runat="server" Visible="true" />
                            </td>
                            <td align="left" colspan="2" valign="top">
                                <font class="blackfnt">Departure time from starting Location (24 Hour Format)</font>
                            </td>
                            <td align="left" valign="top">
                                <asp:TextBox ID="txtSchHH" onblur="checkhour(this)" runat="server"></asp:TextBox>&nbsp;
                                :
                                <asp:TextBox ID="txtSchMM" onblur="checkminute(this)" runat="server"></asp:TextBox><font
                                    class="blackfnt">(HH : MM)</font><asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                        runat="server" ControlToValidate="txtSchHH" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                            <%--<td style="height: 24px; width: 93px">
                                                    </td>--%>
                        </tr>
                        <tr bgcolor="WHITE">
                            <td align="left" valign="top" style="width: 221px">
                                <font class="blackfnt">Standard Rate :</font></td>
                            <td align="left" valign="top">
                                <asp:TextBox ID="txtStandRate" runat="server" onblur="Nagative_Chk_wDecimal(this)"
                                    Width="90px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStandRate"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtStandRate"
                                    ErrorMessage="Enter rate" MaximumValue="100000" MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
                            <td align="left" class="blackfnt" valign="top">
                                Controlling Location :</td>
                            <td align="left" valign="top">
                                <asp:TextBox ID="txtctlloc" runat="server" onblur="checklocation(this)" Width="90px"></asp:TextBox>
                                <asp:Label ID="Label2" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                    Width="14px"></asp:Label></td>
                            <td align="left" valign="top">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td align="left" valign="top">
                                            <font class="blackfnt">Active : </font>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                <ContentTemplate>
                                                    <asp:CheckBox ID="chkActiveFlag" runat="server" AutoPostBack="true" Checked="True"
                                                        OnCheckedChanged="chkActiveFlag_CheckedChanged" /><asp:TextBox ID="txtActFlag" runat="server"
                                                            ReadOnly="True" Width="17px">Y</asp:TextBox>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="chkActiveFlag" EventName="CheckedChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left" valign="top" style="width: 221px">
                            </td>
                            <td align="left" valign="top" style="width: 201px">
                            </td>
                            <td align="left" valign="top">
                            </td>
                            <td align="left" valign="top">
                            </td>
                            <td align="left" valign="top">
                            </td>
                            <%--<td style="width: 93px; height: 14px">"#d4e0e7"
                                                 </td>--%>
                        </tr>
                    </table>
                    <br />
                    <table class="bgbluegrey" border="0" cellpadding="0" cellspacing="0">
                        <tr visible="false">
                            <td align="center" class="blackfnt">
                                <strong>
                                    <asp:Label Visible="false" ID="label1" runat="server" CssClass="blackfnt" Text="Enter Number Of Rows :"></asp:Label></strong><asp:TextBox
                                        ID="TxtRows" Visible="false" runat="server" CssClass="blackfnt" onblur="Nagative_Chk_wDecimal(this)"
                                        Width="44px"></asp:TextBox><%--onblur="Nagative_Chk_wDecimal('ctl00_MyCPH1_TxtRows')"--%><asp:UpdatePanel
                                            ID="UpdatePanel3" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:Button ID="CmdAddRows" Visible="false" CausesValidation="false" runat="server"
                                                    OnClick="CmdAddRows_Click" Text="Add Rows" Width="66px" UseSubmitBehavior="False" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <div style="width: 10in" align="center">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:GridView ShowFooter="true" ID="GrdPaidFollow" runat="server" AutoGenerateColumns="false"
                                    BackColor="white" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" OnRowCreated="GrdPaidFollow_RowCreated"
                                    OnRowDataBound="GrdPaidFollow_RowDataBound" PagerStyle-Mode="NumericPages" PageSize="10"
                                    SelectedIndex="1">
                                    <Columns>
                                        <%--<asp:TemplateField HeaderText="Select">
                                                            <HeaderStyle CssClass="blackfnt" />
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="ChkSelect" runat="server" /> 
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Branch Name">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtbranchname" ReadOnly="true" Text='<%# Eval("LOCCD") %>' runat="server"
                                                    MaxLength="50"></asp:TextBox>
                                               <%-- <atlas:AutoCompleteExtender ID="Extender2" runat="server">
                                                    <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetlocationList"
                                                        ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtbranchname" />
                                                </atlas:AutoCompleteExtender>--%>
                                                 <ajaxToolkit:AutoCompleteExtender ID="Extender2" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                ServiceMethod="GetlocationList" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtbranchname">
                                            </ajaxToolkit:AutoCompleteExtender>
                                                
                                                
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lbltotal" runat="server" Text="Total" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dist (In Km)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtdistance" Text='<%# Eval("DIST_KM") %>' runat="server" MaxLength="100"></asp:TextBox>
                                                <asp:Label ID="lbldistance" runat="server" Visible="false"></asp:Label>
                                                <%--Text='<%# Eval("godown_desc") %>'--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="(Hours)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtttimehr" Text='<%# Eval("TRTIME_HR") %>' runat="server" MaxLength="4"></asp:TextBox>
                                                <asp:Label ID="lblttimehr" runat="server" Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtthtotal" ReadOnly="true"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="(Min)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtttimemn" Text='<%# Eval("TRTIME_MIN") %>' runat="server" MaxLength="2"></asp:TextBox>
                                                <asp:Label ID="lblttimemn" runat="server" Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ReadOnly="true" ID="txttmtotal"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="(Hours)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtstimehr" Text='<%# Eval("STTIME_HR") %>' runat="server" MaxLength="4"></asp:TextBox>
                                                <asp:Label ID="lblstimehr" runat="server" Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ReadOnly="true" ID="txtshtotal"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="(Mins)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtstimemn" Text='<%# Eval("STTIME_MIN") %>' runat="server" MaxLength="2"></asp:TextBox>
                                                <asp:Label ID="lblstimemn" runat="server" Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ReadOnly="true" ID="txtsmtotal"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <div style="width: 10in" align="center">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                    <asp:Button ID="btnUpdt" Visible="true" runat="server" Text="Update Route Master"
                        OnClientClick="return fieldcheck(),checklocationsubmit('ctl00_MyCPH1_txtctlloc')"
                        OnClick="btnUpdt_Click" />
                    <%--checkbranch();--%>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

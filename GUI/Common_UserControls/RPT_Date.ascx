<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RPT_Date.ascx.cs" Inherits="GUI_UNI_MIS_RPT_Date" %>
<link href="../images/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript">

    var FinYear="<%=FinYear %>"
    var FinYear_to=parseInt(FinYear)+1

    if(FinYear_to<10)
    {
        FinYear_to="0"+FinYear_to
    }
    var FinYear_fromdate="01/04/"+FinYear
    var FinYear_todate="31/03/"+FinYear_to
    var Sle_finyear=FinYear+"-"+FinYear_to
    
    var months = new Array("","January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December");
    
    function FinDateCheck()
    {
         var Selection=document.getElementById("<%=radDate.ClientID %>");
         var txtDateFrom=document.getElementById("<%=txtDateFrom.ClientID %>");
         var txtDateTo=document.getElementById("<%=txtDateTo.ClientID %>");
        
        var dt =txtDateFrom.value			
       // alert(dt)
        var dt_dd=dt.substring(0,2)	
        var dt_mm=dt.substring(3,5)
        var dt_yy=dt.substring(6,10)
            
       var fromdt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
       // alert(" hi .." + dt)
       var dt1 =txtDateTo.value			
        //alert(dt)
        var dt_dd1=dt1.substring(0,2)	
        var dt_mm1=dt1.substring(3,5)
        var dt_yy1=dt1.substring(6,10)
        //alert(" hi .." + dt1)
        var todt=new Date(months[parseFloat(dt_mm1)] + " " + parseFloat(dt_dd1) + ", " + parseFloat(dt_yy1))
        //alert(bgndt)
        
    	
        var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
        var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
        var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
        FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

        var FinYear_todate_dd=FinYear_todate.substring(0,2)
        var FinYear_todate_mm=FinYear_todate.substring(3,5)
        var FinYear_todate_yy=FinYear_todate.substring(6,10)
        FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))

        if (fromdt>FinYear_todate1 || fromdt<FinYear_fromdate1)
        {
            alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
            txtDateFrom.focus();
            return false;
        }
        
        if (todt>FinYear_todate1 || todt<FinYear_fromdate1)
        {
            alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
            txtDateTo.focus();
            return false;
        }    
        return true;
    }
    function DateCheck()
    {
        var Selection=document.getElementById("<%=radDate.ClientID %>"+"_0");
        var txtDateFrom=document.getElementById("<%=txtDateFrom.ClientID %>");
        var txtDateTo=document.getElementById("<%=txtDateTo.ClientID %>");

        
        if (Selection.checked==true)
        {      
            if(txtDateFrom.value=="")
		     {
		         alert("Please enter the From Date")
		         txtDateFrom.focus();
		         return false;
		     }
		     if(txtDateFrom.value!="")
			 {
				if (ValidateForm(txtDateFrom)==false)
				{
				    return false;
				}
			 }
			 if(txtDateTo.value=="")
		    {
		         alert("Please enter the To Date")
		         txtDateTo.focus();
		        return false;
		    }
		    if(txtDateTo.value!="")
			 {
				if (ValidateForm(txtDateTo)==false)
				{
				    return false;
				}
			 }
			 
			 var dt =txtDateFrom.value			
                //alert(dt)
	            var dt_dd=dt.substring(0,2)	
	            var dt_mm=dt.substring(3,5)
	            var dt_yy=dt.substring(6,10)
		            
	           var fromdt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	           // alert(" hi .." + dt)
	          var dt1 =txtDateTo.value			
                //alert(dt)
	            var dt_dd1=dt1.substring(0,2)	
	            var dt_mm1=dt1.substring(3,5)
	            var dt_yy1=dt1.substring(6,10)
		          //  alert(" hi .." + dt1)
	          var todt=new Date(months[parseFloat(dt_mm1)] + " " + parseFloat(dt_dd1) + ", " + parseFloat(dt_yy1))
	            //alert(bgndt)
            			
	            currdate="<%=currdate %>"
	            dt_dd=currdate.substring(0,2)
	            dt_mm=currdate.substring(3,5)
	            dt_yy=currdate.substring(6,10)
	           // alert("hi")
	            currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            		
            	//alert(currdate)
	            if (currdate < fromdt)
	            {
			            alert("From Date should be less than or equal to  system Date \n")
			            txtDateFrom.focus();
			            return false;
	            }
	            
	            if (currdate < todt)
	            {
			            alert("To Date should be less than or equal to  system Date \n")
			            txtDateTo.focus();
			            return false;
	            }
            		
            	if (todt < fromdt)
	            {
			            alert("To Date should be Greter than From Date \n")
			            txtDateTo.focus();
			            return false;
	            }
	            
	            if (todt < fromdt)
	            {
			            alert("From Date should be less than To Date \n")
			            txtDateFrom.focus();
			            return false;
	            }
            
        }
        return true;
        
    }
    //function formatDate_1(dateString){var inputDate=dateString.split("/");return inputDate[1]+"/"+inputDate[0]+"/"+inputDate[2]}
    //function isDate_1(dateString){var datePat=/^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;var matchArray=dateString.match(datePat);if(matchArray==null)return false;month=matchArray[1];day=matchArray[3];year=matchArray[5];if(month<1||month>12)return false;if(day<1||day>31)return false;if((month==4||month==6||month==9||month==11)&&day==31)return false;if(month==2){var isleap=(year%4==0&&(year%100!=0||year%400==0));if(day>29||(day==29&&!isleap))return false;}return true;}
    function makeDate_1(day, month, year){var returnDate="";if(day<10)returnDate="0"+day+"/";else returnDate=day+"/";if(month<10)returnDate+="0"+month+"/"+year;else returnDate+=month+"/"+year;return returnDate;}
    
    function markDateRange()
    {
        var tb_From_Date=document.getElementById("<%=txtDateFrom.ClientID %>");
        var tb_To_Date=document.getElementById("<%=txtDateTo.ClientID %>");
        
        var rbl_Date_Range = document.getElementById("<%=radDate.ClientID %>_0");
        if(!rbl_Date_Range.checked)
        {
            rbl_Date_Range.checked=true;
            tb_From_Date.value = "";
            tb_To_Date.value = "";
            
            tb_From_Date.disabled=false;
            tb_To_Date.disabled=false;
        }
        return false;
    }
    function makeDateRange()
    {
        var rbl_Date_Range = document.getElementById("<%=radDate.ClientID %>_0");
        var rbl_Last_7_Days = document.getElementById("<%=radDate.ClientID %>_1");
        var rbl_Today = document.getElementById("<%=radDate.ClientID %>_2");
        var rbl_Till_Date = document.getElementById("<%=radDate.ClientID %>_3");
        
        var tb_From_Date=document.getElementById("<%=txtDateFrom.ClientID %>");
        var tb_To_Date=document.getElementById("<%=txtDateTo.ClientID %>");
             
        var toDay = new Date();

        if (rbl_Date_Range.checked) {
            tb_From_Date.value = "";
            tb_To_Date.value = "";
            
            tb_From_Date.disabled=false;
            tb_To_Date.disabled=false;
        }
        else if (rbl_Last_7_Days.checked) {
            toDay.setDate(toDay.getDate() - 7);
            tb_From_Date.value = makeDate_1(toDay.getDate(), toDay.getMonth() + 1, toDay.getFullYear());
            toDay.setDate(toDay.getDate() + 7);
            tb_To_Date.value = makeDate_1(toDay.getDate(), toDay.getMonth() + 1, toDay.getFullYear());
            tb_From_Date.disabled=true;
            tb_To_Date.disabled=true;
        }
        else if (rbl_Today.checked) {
            tb_From_Date.value = makeDate_1(toDay.getDate(), toDay.getMonth() + 1, toDay.getFullYear());
            tb_To_Date.value = makeDate_1(toDay.getDate(), toDay.getMonth() + 1, toDay.getFullYear());
            tb_From_Date.disabled=true;
            tb_To_Date.disabled=true;
        }
        else if (rbl_Till_Date.checked) {
            tb_From_Date.value = "01/01/1950";
            tb_To_Date.value = makeDate_1(toDay.getDate(), toDay.getMonth() + 1, toDay.getFullYear());
            tb_From_Date.disabled=true;
            tb_To_Date.disabled=true;
        }   
        return false;      
    }
    </script>


<div>
    <div id="tabs" style="text-align: left; padding: 0px 0px 0px 0px; color: Black; border-bottom-color:Gray">
        <table cellspacing="1" cellpadding="3" border="0" class="boxbg" style="width: 100%">
            <tr style="background-color: white" id="trDtCri" runat="server">              
                    <td>
                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                            Width="210px">
                            <asp:ListItem  Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                            <asp:ListItem Selected="True" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td valign="top" colspan="5">
                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: " ></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60" onblur="javascript:isValidDate(this.value,'From Date!!!')"
                            MaxLength="10" CssClass="input"></asp:TextBox>
                        <a href="#" onclick="<%=JSFromDT %>" name="anchor1" id="anchor1">
                            <img src="~/GUI/images/calendar.jpg" runat="server" id="imgfrm" border="0" />
                        </a>
                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60" onblur="javascript:isValidDate(this.value,'To Date!!!')"
                            MaxLength="10" CssClass="input"></asp:TextBox>
                        <a href="#" onclick="<%=JSToDT %>" name="anchor2" id="anchor2">
                            <img src="~/GUI/images/calendar.jpg"  runat="server" id="imgto" border="0" />
                        </a>
                    </td>
            </tr>
        </table>
    </div>
</div>

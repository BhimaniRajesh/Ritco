<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
     CodeFile="Chq_Reoffer_Step1.aspx.cs"  Inherits="GUI_Finance_Accounts_Debit_Voucher_DebitVoucher"
    Title="Cheque Bounce" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
     <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	  var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
      var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
 function ValidateDate(obj)
    {

      if (obj.value!="")
      {
        
	    if (isDate(obj.value)==false)
	    {
    	
		    obj.focus()
		    return false
	    }
        return true
      }
    }
     var dtCh= "/";
     var minYear="1900";
    var maxYear="2100";
     function DaysArray(n) 
     {
	    for (var i = 1; i <= n; i++) 
	    {
		    this[i] = 31
		    if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
		    if (i==2) {this[i] = 29}
       } 
        return this
     }
   function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
	return true
}
Frm_Name="ctl00_MyCPH1_"
function Chq_Submit()
{
    if(document.getElementById(Frm_Name+"TxtChqNo").value=="")
    {
        alert("Plz Enter Cheque NO.")
        document.getElementById(Frm_Name+"TxtChqNo").focus();
        return false;
    }
    if(document.getElementById(Frm_Name+"TxtChqdt").value=="")
    {
        alert("Plz Enter Cheque Date.")
        document.getElementById(Frm_Name+"TxtChqdt").focus();
        return false;
    }
//    if(!Chq_valid_YN())
//    {
//        alert(Chq_valid_YN())
//        return false;
//    }
}
function Chq_Bounce_Validate()
{
                    if(document.getElementById(Frm_Name+"TxtBounceDate").value=="")
                    {
                        alert("Plz Enter Cheque Reoffer Date.")
                        document.getElementById(Frm_Name+"TxtReofferDate").focus();
                        return false;
                    }
                 
                 var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
                 var dt =document.getElementById(Frm_Name+"TxtReofferDate").value
				 var hdndockdt;
			     var Maxdt="01/01/2007";
			     mTotalRecords=document.getElementById(Frm_Name+"hnd_Count").value
			   //  alert(mTotalRecords)
			     for (var i=0; i < mTotalRecords; i++)
                 {
                   
                                        j = i + 2;
                                        if(j < 10)
                                        {
                                            hdndockdt = "ctl00_MyCPH1_GR_DepoDetail_ctl" + "0" + j + "_hnd_VR_FinColDt";
                                          //  alert(hdndockdt)
                                            hdndockdt = document.getElementById(hdndockdt).value;
                                          //  alert(hdndockdt)
                                           // chkbill1= "ctl00_MyCPH1_GV_Booking_ctl" + "0" + j + "_chkbill";
                                        }
                                        else
                                        {
                                            
                                            hdndockdt = "ctl00_MyCPH1_GR_DepoDetail_ctl" + j + "_hnd_VR_FinColDt";
                                            hdndockdt = document.getElementById(hdndockdt).value;
                                           // chkbill1= "ctl00_MyCPH1_GV_Booking_ctl" + j + "_chkbill";
                                        }
                    
                                             var Maxdt1 =Maxdt
                            				
				                             var Maxdt_dd=Maxdt1.substring(0,2)
				                             var Maxdt_mm=Maxdt1.substring(3,5)
				                             var Maxdt_yy=Maxdt1.substring(6,10)
                                                
		                                     var hdndockdt1 =hdndockdt
				                             var hdndockdt_dd=hdndockdt1.substring(0,2)
				                             var hdndockdt_mm=hdndockdt1.substring(3,5)
				                             var hdndockdt_yy=hdndockdt1.substring(6,10)
                        				    
				                             Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                                     hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                       
                                            if (hdndockdt1>Maxdt1)
                                            {
                                            Maxdt1=hdndockdt1
                                            Maxdt=hdndockdt
                                            }
                                        
               
                        }
				                  // alert("hill")
				                    var dt_dd=dt.substring(0,2)
				                    var dt_mm=dt.substring(3,5)
				                    var dt_yy=dt.substring(6,10)

		                            var sdt =server_dt
				                    var sdt_dd=sdt.substring(0,2)
				                    var sdt_mm=sdt.substring(3,5)
				                    var sdt_yy=sdt.substring(6,10)
            				
				
				                dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                    
                                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				                var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				                var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				                FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
                				
				                var FinYear_todate_dd=FinYear_todate.substring(0,2)
				                var FinYear_todate_mm=FinYear_todate.substring(3,5)
				                var FinYear_todate_yy=FinYear_todate.substring(6,10)
				                FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
                			
				                if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				                {
						                alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Cheque Bounce Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						                document.getElementById(Frm_Name+"TxtReofferDate").focus();
						                return false;
				                }
                				
                                Fromdate1=Maxdt1
			                    Fromdate=Maxdt
			                  //  alert(Fromdate1)
                              if (dt<Fromdate1)
				                {
						                alert( "Cheque Bounce Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(Frm_Name+"TxtReofferDate").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Cheque Bounce Date should not be greater than today's date !!!")
						                document.getElementById(Frm_Name+"TxtReofferDate").focus();
						                return false;
				                }
				          document.getElementById(Frm_Name+"TxtReofferDate").disabled=false 
				          document.getElementById(Frm_Name+"TxtChqNo").disabled=false
				          document.getElementById(Frm_Name+"TxtChqdt").disabled=false
				                
}
function Chq_valid_YN()
{
    //debugger;
    var Chqno=document.getElementById(Frm_Name+"TxtChqNo");
    var ChqNumber = Chqno.value;
    var ChqDate = document.getElementById(Frm_Name+"TxtChqdt").value;
//    if(document.getElementById(Frm_Name+"TxtChqNo").value=="")
//    {
//        alert("Plz Enter Cheque NO.")
//        document.getElementById(Frm_Name+"TxtChqNo").focus();
//        return false;
//    }
//    if(document.getElementById(Frm_Name+"TxtChqdt").value=="")
//    {
//        alert("Plz Enter Cheque Date.")
//        document.getElementById(Frm_Name+"TxtChqdt").focus();
//        return false;
//    }
    if(ChqDate !="" && ChqNumber !="")
    {
                var findobj=false;
                findobj=GetXMLHttpObject();
                var Flag="F"
                if(findobj)
                {
                
                 var strpg="CheckExist.aspx?mode=Cheque&Chqno=" + ChqNumber + "&ChqDate=" + ChqDate + "&sid=" + Math.random();
                 findobj.open("GET",strpg,true);
                 findobj.onreadystatechange=function()
                     {
                         if(findobj.readyState==4 && findobj.status==200)
                            {
                                var res=findobj.responseText.split("|");
                                if(res[0]=="F")
                                {
                                    alert(res[1])
                                    Flag="F"
                                    document.getElementById(Frm_Name+"TxtChqNo").value="";
                                    document.getElementById(Frm_Name+"TxtChqdt").value="";
                                    document.getElementById(Frm_Name+"TxtChqNo").focus();
                                    return false;
                                }
                                else if(res[0]=="Y")
                                {
                                    Flag="Y"
                                    document.getElementById(Frm_Name+"Button1").disabled=false;
                                    document.getElementById(Frm_Name+"TxtChqdt").disabled=true;
                                    document.getElementById(Frm_Name+"TxtChqNo").disabled=true;
                                    
                                     return true;
                                }
                            }
                     }
                findobj.send(null);
                }
    }
}
</script>
   
    <div style="width: 10.0in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" border="0" /></a>
    </div>
    
    <div style="text-align: center; width: 10.0in">
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
     <ContentTemplate>  
    <table  width="1000" align="left" >
           <tr><td>
            <table cellspacing="1" class="boxbg" width="100%">
                <tr class="bgbluegrey">
                    <td align="center">
                        <strong>Cheque Bounce Module</strong>
                    </td>
                </tr>
            </table>
           </td></tr>
           <!----1---->
             <tr><td>
                   <table cellspacing="1" class="boxbg" width="100%">
                    
                        <tr  bgcolor="white">
                                <td align="center">
                                    <strong>Enter Cheque/Date No.</strong>
                                </td>
                                <td align="Left">
                                    <asp:TextBox ID="TxtChqNo" runat="server" Text=""  MaxLength="6" Columns="8">    </asp:TextBox>
                                      
                                    <asp:TextBox ID="TxtChqdt" onblur="javascript:ValidateDate(this)" runat="server" Text=""  MaxLength="10" Columns="9">    </asp:TextBox><%--<a href="#" onclick="cal.select(ctl00$MyCPH1$TxtChqdt,'anchor1','dd/MM/yyyy'); return false;"
                                    id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>--%>
                                    &nbsp;&nbsp;&nbsp;<asp:Button ID="Button1"  Enabled="false" runat="server"  CssClass="blackfnt"   BorderWidth="1px" Text="Click Here TO Reoffer Cheque" Width="350px" OnClick="btnSubmit_Click" />
                                    <asp:HiddenField ID="hnd_Count" Value='0' runat="server" />
                                </td>
                        </tr>
                        <tr   bgcolor="white" id="BounceDate_Row" runat="server" visible="false">
                                <td align="center">
                                    <strong>Enter Cheque Reoffer  Date.</strong>
                                </td>
                                <td align="Left">
                                       
                                    <asp:TextBox ID="TxtReofferDate"  onblur="javascript:ValidateDate(this)" runat="server" Text=""  MaxLength="10" Columns="10">    </asp:TextBox><a href="#" onclick="cal.select(ctl00$MyCPH1$TxtBounceDate,'anchor11','dd/MM/yyyy'); return false;"
                                    id="a1" name="anchor11"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    
                                </td>
                        </tr>
                    </table>
             </td></tr>
           <!----3---->
         </table>
       </ContentTemplate> </asp:UpdatePanel>
    </div>
    <br />
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
     <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
        <br />
</asp:Content>

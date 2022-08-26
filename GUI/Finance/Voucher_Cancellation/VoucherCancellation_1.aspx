<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VoucherCancellation.aspx.cs" Inherits="GUI_Operations_VoucherCancellation" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript">
    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	var client_name="<%=Session["Client"]%>"
	var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
		
	var FinYear="<%=Session["FinYear"]%>"
	var FinYear_to=parseInt(FinYear)+1
	
	if(FinYear_to<10)
	{
	FinYear_to="0"+FinYear_to
	}
	var FinYear_fromdate="01/04/"+FinYear
	var FinYear_todate="31/03/"+FinYear_to
	var Sle_finyear=FinYear+"-"+FinYear_to
	
	function checkdata()
	{
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var r=tbl.rows.length;
        var non=0;
   
       for(var i=2;i<r;i++)
       {
            var ChkSel,txtVCDate,txtvoucherno
            if(i<10)
                {
                    ChkSel=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$ChkSel");
                    txtVCDate=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtVCDate");
                    txtvoucherno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtVoucherNo");
                }
            else
                {
                    ChkSel=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$ChkSel");
                    txtVCDate=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtVCDate");
                    txtvoucherno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtVoucherNo");
                }
            
            if(ChkSel.checked == true)
            {    
                if(txtvoucherno.value != "")
                {
                    if(!isValidDate(txtVCDate.value,"Voucher"))
                    {
                        txtVCDate.focus();
                        return false;
                     }   
                    var dt =txtVCDate.value
                    var dt_dd=dt.substring(0,2)
	                var dt_mm=dt.substring(3,5)
	                var dt_yy=dt.substring(6,10)

                    var sdt =server_dt
	                var sdt_dd=sdt.substring(0,2)
	                var sdt_mm=sdt.substring(3,5)
	                var sdt_yy=sdt.substring(6,10)
    				
                    dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                    server_dt1=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
       
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
						    alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						    txtVCDate.focus();
						    return false;
				    }
				    if (dt>server_dt1)
                    {
		                    alert( "Voucher Cancellation Date should not be greater than today's date !!!")
		                    txtVCDate.focus();
		                    return false;
                    } 
                }
                if(txtvoucherno.value != "")
                {
                    non=1;
                }
           }     
                
        } /// end for

        if(non==0)
        {
            alert("There is no Voucher Number to Update.........");
            return false;
        }
    
    }
    function voucherBlur(id)
    {
        
        var str="";
        for(var i=0;i<id.length-12;i++)
        {
            str+=id.charAt(i);
        }
        var s1=str+"txtVDate"
        var txtvoucherno=document.getElementById(id);
        var txtVDate=document.getElementById(s1);
           
        var voucherno=txtvoucherno.value;
        if(voucherno=="")
        {
            return false;
        }
     
        var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var r=tbl.rows.length;
       
       for(var i=2;i<r;i++)
       {
            var txtno;
            if(i<10)
                txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtVoucherNo");
            else
                txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtVoucherNo");

             if(txtvoucherno.value==txtno.value)
               {
                    if(txtvoucherno.getAttribute('id')!=txtno.getAttribute('id'))
                    {
                        alert("Duplicate Voucher Number....Enter another Voucher Number....");
                        txtvoucherno.value="";
                        txtvoucherno.focus();
                        return false;
                    }
               }
     
        }
        
        
        var findobj=false;
        findobj=GetXMLHttpObject();
        if(findobj)
        {
         var strpg="BringVoucherDetails.aspx?mode=date&code=" + voucherno + "&sid=" + Math.random();
         findobj.open("GET",strpg,true);
         findobj.onreadystatechange=function()
             {
                 if(findobj.readyState==4 && findobj.status==200)
                    {
                        //debugger;
                        var res=findobj.responseText.split("|");
                        if(res[0]=="true")
                            txtVDate.innerText=res[1];
                        else if(res[0]=="false")
                            {
                                alert(res[1]);
                                txtvoucherno.value="";
                                txtvoucherno.focus();
                                return false;
                            }
                    }
             }
             
        findobj.send(null);
        }
        return false;
    }
	
	function ValidateForm(obj)
    {
      if (obj.value!="")
      {
	    if (isDate(obj.value)==false)
	    {
    	
		    obj.focus()
		    obj.value = ""
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
function VisibleDate(id_ChkSel,id_pnlDate)
{
    if(document.getElementById(id_ChkSel).checked == true)
    {
        document.getElementById(id_pnlDate).style.display = "block";
    }
    else
    {
         document.getElementById(id_pnlDate).style.display = "none";
    }
    return true;
}
</script>
<div align="left" style="width: 10.0in;">

<table align="center" cellpadding="0" cellspacing="0" border="0" width="8"> 
<tr>
<td style="text-align:right">
<a href="javascript:window.history.go(-1)" title="back"><img alt="bck" src="../../images/back.gif" style="border:0" /></a>
</td>
</tr>
<tr>
<td>
<table style="WIDTH: 8.5in" class="boxbg" cellspacing="1" align="center"><tr class="bgbluegrey"><td align="center"><strong>Voucher Cancellation</strong></td></tr></table>

<asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <br />
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
</td>
</tr>
<tr>
<td>
<br />
<asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline" >
        <ContentTemplate>
<table style="WIDTH: 8.5in" class="boxbg" cellspacing="1" align="center">
<tr style="background-color: #ffffff"><td align="center" colspan="2">Enter No. of Rows : <asp:TextBox ID="txtRows" Width="50px" runat="server" BorderStyle="Groove">5</asp:TextBox>
<asp:Button ID="btnRows" runat="server"  Text="Add Rows" Width="68px" OnClick="btnRows_Click" /></td></tr>
<tr style="background-color: #ffffff">
    <td>
        <table style="WIDTH: 8in" border="0" cellspacing="1" align="center">
            <tr>
                <td align="right" width="377px">Cancel Reason  : </td>
                <td align="left"><asp:TextBox ID="txtcancel" Width="200px" MaxLength="250" runat="server" TextMode="MultiLine" BorderStyle="Groove"></asp:TextBox></td>
            </tr>    
        </table>
    </td>
</tr>
    <tr style="background-color: #ffffff">
        <td align="center" colspan="2">
        <br />
            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                CellSpacing="1" CssClass="boxbg"  EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                 PagerSettings-FirstPageText="[First]"
                PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left"
                 OnRowDataBound="grvcontrols_RowDataBound">
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="boxbg" />
                <Columns>
                   
                    <asp:TemplateField HeaderText="Sr. No.">
                        <ItemStyle BackColor="White" Width="50" CssClass="blackfnt" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Voucher No.">
                        <ItemStyle BackColor="White" Width="170" CssClass="blackfnt" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        <ItemTemplate>
                            &nbsp;<asp:TextBox ID="txtVoucherNo" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                Enabled="true" MaxLength="50" Width="135px"></asp:TextBox>
                                <%--<asp:Button ID="btnVoucherNo" runat="server" CssClass="blackfnt" Text="..." />--%>&nbsp;
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Voucher Date">
                        <ItemStyle BackColor="White" Width="100" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        <ItemTemplate>
                            &nbsp;<%--<asp:TextBox ID="txtVDate" runat="server" BorderStyle="Groove" MaxLength="10"
                                onblur="javascript:ValidateForm(this)" Width="70px"></asp:TextBox>--%>
                            <asp:Label ID="txtVDate" runat="server"></asp:Label>    
                            <%--<asp:LinkButton ID="lnkBtnVDate" runat="server">
                                                <img src="../../images/calendar.jpg" border="0" alt="" /></a>
                                         </asp:LinkButton>--%>&nbsp;
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText="Cancellation Date" >
                                    <ItemStyle  CssClass="blackfnt" Width="170" HorizontalAlign="Center" BackColor="White" Wrap="False" />
                                    <HeaderStyle CssClass="blackfnt" BackColor="#D4E0E7"  HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                        <asp:CheckBox ID="ChkSel" runat="server" />&nbsp;</td>
                                                <td>
                                                    <asp:Panel ID="pnlDate" runat="server"  style="display:none">
                                        <asp:TextBox ID="txtVCDate" runat="server"  BorderStyle="Groove" MaxLength="10" 
                                            Width="70px"></asp:TextBox><asp:LinkButton ID="lnkBtnVCDate" runat="server">
                                                <img src="../../images/calendar.jpg" border="0" alt=""  /></a>
                                         </asp:LinkButton></asp:Panel>
                                                </td>
                                            </tr>
                                        </table>                                     
                                    </ItemTemplate>
                                </asp:TemplateField>
                   
                </Columns>
                <PagerStyle HorizontalAlign="Left" />
            </asp:GridView>
            <br />
        </td>
    </tr>
    <tr  style="background-color: #ffffff">
    <td style="text-align:center" colspan="2">
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript: return checkdata()" OnClick="submit"/>
    </td>
    </tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
</td>
</tr>
</table>

</div>
<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></div>     
</asp:Content>


<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Advice_Cancellation.aspx.cs" Inherits="GUI_Finance_Accounts_Advice_Cancellation" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
<script type="text/javascript" language="javascript">
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


function checkboxclick(id)
{
   //debugger;
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=2;i<=r;i++)
   {
        var txtcanceldt,chkcancel,srnocheckbox,txtadviceno,txtcancelreason;
        if(i<10)
            {
                txtadviceno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtadviceno");
                txtcanceldt=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtcanceldt");
                chkcancel=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$chkcancel");
                srnocheckbox=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$chkboxsrno");
                txtcancelreason=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtcancelreason");
            }
        else
            {
                txtadviceno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtadviceno");
                txtcanceldt=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtcanceldt");
                chkcancel=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$chkcancel");
                srnocheckbox=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$chkboxsrno");
                txtcancelreason=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtcancelreason");
            }
        if(srnocheckbox.checked == true)
        {
            txtadviceno.disabled = false;
            chkcancel.disabled = false;
            
            if(chkcancel.checked == true)
            {
                txtcanceldt.disabled = false
                txtcancelreason.disabled = false;
                //return true;
            }  
            if(chkcancel.checked == false)
            {
                txtcanceldt.value = ""
                txtcanceldt.disabled = true
                
                txtcancelreason.value = ""
                txtcancelreason.disabled = true
            }
        } 
        else
        {
            txtadviceno.disabled = true;
            chkcancel.disabled = true;
        }   
   }
}
function locBlur(id)
{   
    var txt=document.getElementById(id);
    
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=loc&code=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       //debugger;
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Location Is not Valid..Enter Proper Location Code....");
                            txt.value="";
                            return false;
                       }
                }
          }
        findobj.send(null);
    }
}

function AdviceBlur(id)
{
    var txt=document.getElementById(id);
    var advdt=id.substring(0,id.length-11) + "lbladvdt";
    var raisedon = id.substring(0,id.length-11) + "txtraisedon";
    var hdnadvdt = id.substring(0,id.length-11) + "hdnadvdt";

    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="AdviceCheckExist.aspx?adviceno=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       //debugger;
                       var res=findobj.responseText.split("|");
                       if(res[0]=="N")
                       {
                            alert("Advice Is not Valid..Enter Proper Advice Code....");
                            txt.value="";
                            return false;
                       }
                       else if(res[3]!="SUBMITTED")
                       {
                            alert("Advice Is Already " +res[3]);
                            txt.value="";
                            return false;
                       }
                       else if(res[4]!="N")
                       {
                            alert("Advice Is Already Cancelled");
                            txt.value="";
                            return false;
                       }
                       else
                       {
                            document.getElementById(advdt).innerText = res[1]
                            document.getElementById(raisedon).value = res[2]
                            document.getElementById(hdnadvdt).value = res[1]
                       }//obj.innerText

                }
          }
        findobj.send(null);
    }
}
function CheckFinacialYear(date,voucher)
{
    //alert(date.value);
    var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
    var dt =date.value;
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
		alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO " + voucher + " Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
		//date.focus();
		return false;
	}
	/*if (dt>server_dt)
	{
        alert( voucher + " Date should not be Greater than today's date !!!")
        date.focus();
        return false;
	}*/
	return true;   
} 
function validateBoxes()
{
   //debugger;
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=2;i<=r;i++)
   {
        //debugger;    
        var txtcanceldt,txtcancelreason,lbladvdt;
        var chkboxsrno,chkcancel,txtadviceno,txtraisedon;
        if(i<10)
            {
                txtcanceldt=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtcanceldt");
                txtcancelreason=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtcancelreason");
                txtadviceno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtadviceno");
                txtraisedon=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtraisedon");
                chkboxsrno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$chkboxsrno");
                chkcancel=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$chkcancel");
                hdnadvdt=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$hdnadvdt");
            }
        else
            {
                txtcanceldt=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtcanceldt");
                txtcancelreason=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtcancelreason");
                txtadviceno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtadviceno");
                txtraisedon=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtraisedon");
                chkboxsrno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$chkboxsrno");
                chkcancel=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$chkcancel");
                hdnadvdt=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$hdnadvdt");
            }
            if(chkboxsrno.checked == true)
            {
                non = 1;
                if(txtadviceno.value == "")
                {
                    alert("Plz Enter the Advice No");
                    txtadviceno.focus();
                    return false;
                }
                
                //alert(lbladvdt.innerText)
                
                var Advicedateflag = CheckFinacialYear(hdnadvdt,"Advice")
                if(!Advicedateflag)
                {
                    txtadviceno.value="";
                    return false;     
                }
                
                if(txtraisedon.value == "")
                {
                    alert("Plz Enter the Raised On Location");
                    txtraisedon.focus();
                    return false;
                }
                //debugger;
                if(chkcancel.checked == true)
                {
                    if(txtcanceldt.value == "" || txtcancelreason.value == "")
                    {
                        alert("Plz Enter the Cancel Date and Cancel Reason");
                        txtcanceldt.focus();
                        return false;        
                    }
                    else
                    {
                        if(txtcanceldt.value != "" && txtcancelreason.value != "")
                        {   
                            if(!isValidDate(txtcanceldt.value,"Voucher"))
                            {
                                txtcanceldt.focus();
                                return false;
                            }   
                            var dt =txtcanceldt.value
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
						            txtcanceldt.focus();
						            return false;
				            }
				            if (dt>server_dt1)
                            {
		                            alert( "Advice Cancellation Date should not be greater than today's date !!!")
		                            txtcanceldt.focus();
		                            return false;
                            }
                        }
                    }   
                }
            }
    } /// end for
    if(non==0)
    {
        alert("Plz Check The Check Box For Cancel or Update the Advice");
        return false;
    }
}
function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
            return false;
 }

function addRows()
{
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}

</script>
<div align="left" style="width: 10in;">
        <br />
        <br />
        <br /><br />
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="100%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center"><b>
                    Advice Cancellation</b>
                </td>
            </tr>
        </table>
        
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="right" width="50%">
                            Enter No. of Rows </td>
                        <td class="blackfnt" align="left" width="50%">
                            <asp:TextBox runat="server" ID="txtnorows" Width="40px" style="text-align:right;" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                            <asp:Button runat="server" Text="Add Rows" CssClass="blackfnt" OnClick="btnrows_Click" ID="btnrows" />
                        </td>
                    </tr>
                </table>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left">
                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                AllowPaging="true" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnRowDataBound="grvcontrols_RowDataBound">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <%--<asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>--%>
                                            <asp:CheckBox ID="chkboxsrno" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Advice No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server"  BorderStyle="Groove" MaxLength="25" Width="100px" ID="txtadviceno"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Advice Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%--<asp:TextBox ID="txtadvdt" Enabled="false" BorderStyle="Groove" MaxLength="5" Width="60px" runat="server"></asp:TextBox>--%>
                                            <asp:Label ID="lbladvdt" runat="server" Enabled="true"></asp:Label>
                                            <asp:HiddenField ID="hdnadvdt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Raised On">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtraisedon" BorderStyle="Groove" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                            <%--<asp:Button ID="btnraisedon" Text="..." CssClass="blackfnt" runat="server" />--%>
                                            <input type="button" id="btnraisedon" runat="server" value="...." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cancel">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkcancel" runat="server" Enabled="true"/>
                                            <%--<asp:TextBox ID="txtcancel" Enabled="false" BorderStyle="Groove" MaxLength="5" Width="60px" runat="server"></asp:TextBox>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cancel Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtcanceldt" Enabled="false" BorderStyle="Groove" MaxLength="10" Width="60px" runat="server"></asp:TextBox>
                                            <asp:LinkButton ID="linkdtbtn" runat="server">
                                                <img src="../../images/calendar.jpg" border="0" alt="" /></a>
                                                <font face="verdana" size="1">(dd/mm/yyyy)</font>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cancel Reason">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtcancelreason" Enabled="false" MaxLength="250" BorderStyle="Groove" onchange="javascript:this.value=this.value.toUpperCase()" TextMode="MultiLine" Width="120px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    </ContentTemplate>
                </asp:UpdatePanel>   
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center">
                        <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt"
                            ID="btnsubmit"></asp:Button>
                    </td>
                </tr>
             </table>
</div>   
<DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>          
</asp:Content>


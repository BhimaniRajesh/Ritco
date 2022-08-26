<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Bill_Cancellation_step_2.aspx.cs" Inherits="GUI_Finance_Bill_MR_Cancellation_Bill_Cancellation_step_2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
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
    
function CheckFinacialYear(date,voucher)
{
    //debugger;
    var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
    var dt =date.value
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
	    alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO  Bill Cancellation Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
	    date.focus();
	    return false;
    }
	
    if (dt>server_dt)
     {
        alert( voucher + " Date should not be greater than today's date !!!")
        date.focus();
        return false;
     }
     return true;
}
function Checkall(obj)
    {   
        Str="";
        var pref = "ctl00_MyCPH1_grvcontrols";
        var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var Totalcount=tbl.rows.length;
        var chkbillno;
        if(obj.checked == true)
        {
            for(i = 2; i <= Totalcount ; i++)
            {
                if(i<10)
                {  
                   chkbillno = document.getElementById(pref + "_ctl0" + i + "_chkbillno");
                }
                else
                {  
                   chkbillno = document.getElementById(pref + "_ctl" + i + "_chkbillno");
                }
                
                chkbillno.checked = true;    
            }
        }
        else if(obj.checked == false)
        {
            for(i = 2; i <= Totalcount ; i++)
            {
                if(i<10)
                {  
                   chkbillno = document.getElementById(pref + "_ctl0" + i + "_chkbillno");
                }
                else
                {  
                   chkbillno = document.getElementById(pref + "_ctl" + i + "_chkbillno");
                }
                
                chkbillno.checked = false;    
            }
        }
    }
function CheckData()
{
    var prefix = "ctl00_MyCPH1_"; 
    var grvcontrol = "ctl00_MyCPH1_grvcontrols";
    var txtbilldt = document.getElementById(prefix + "txtbilldt");
    var txtreson = document.getElementById(prefix + "txtreson");
    var click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)
    
    if(txtbilldt.value == "")
    {
        alert("Please Enter Bill Cancellation Date");
        txtbilldt.focus();
        return false;
    }
    if(!isValidDate(txtbilldt.value,"Bill Cancellation"))
    {
        txtbilldt.value = "";
        txtbilldt.focus();
        return false;
     }
    var dateflag = CheckFinacialYear(txtbilldt,"Bill Cancellation");
    if(!dateflag)
        return false;
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
    var Totalcount=tbl.rows.length;
    var chkbillno,hdnbilldt;
    var non=0;
    for(i = 2; i <= Totalcount ; i++)
    {
        if(i<10)
        {
           hdnbilldt = document.getElementById(grvcontrol + "_ctl0" + i + "_hdnbilldt");
           chkbillno = document.getElementById(grvcontrol + "_ctl0" + i + "_chkbillno");
        }
        else
        {
           hdnbilldt = document.getElementById(grvcontrol + "_ctl" + i + "_hdnbilldt");
           chkbillno = document.getElementById(grvcontrol + "_ctl" + i + "_chkbillno");
        }
       
        if(chkbillno.checked == true)
        {
                non = 1;
                var chq_dt = hdnbilldt.value
                var voucher_dt = txtbilldt.value
                
                var vdt_dd=voucher_dt.substring(0,2)
                var vdt_mm=voucher_dt.substring(3,5)
                var vdt_yy=voucher_dt.substring(6,10)
                
                var cdt =chq_dt
                var cdt_dd=cdt.substring(0,2)
                var cdt_mm=cdt.substring(3,5)
                var cdt_yy=cdt.substring(6,10)

                voucher_dt=new Date(months[parseFloat(vdt_mm)] + " " + parseFloat(vdt_dd) + ", " + parseFloat(vdt_yy))
                chq_dt=new Date(months[parseFloat(cdt_mm)] + " " + parseFloat(cdt_dd) + ", " + parseFloat(cdt_yy))
                	
                if (voucher_dt < chq_dt)
                {
	                alert("Bill Cancellation Date Should Not Be Less than Bill Generation Date!!!")
	                txtbilldt.value = "";
	                txtbilldt.focus();
	                return false;
                }
        }
    }
    if(non == 0)
    {
        alert("Plz Select Atleast One Bill Number!!!");
        return false;
    }
    if(click_count > 0)
    {
        alert("Sorry... You cannot click twice !!!")
        return false;
    }
    else
    {
        click_count=click_count+1
        document.getElementById("ctl00_MyCPH1_click_count").value=click_count
    } 
    return true;   
}    
</script> 
<asp:UpdatePanel ID="UpdatePanel1" runat="Server">
<ContentTemplate>
<br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                        <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                    width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                    runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
<br />   
<table width="70%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
    <tr>
        <td>
            <font class="blackfnt"><a href=""><b><u>Exceptions </u></b></a>&gt; 
            <a href=""><b><u>Finance & Accounts</u></b></a>&gt;
            <a href=""><b><u>Bill Cancellation</u></b></a></font>
        </td>
        <%--<td>
            <a href="javascript:window.history.go(-1)" title="back">
            <img src="../../images/back.gif" border="0" alt="" /></a>
        </td>--%>
    </tr>
</table>
<div align="left" style="width: 10in;">
    <table cellspacing="1" width="50%" align="center" class="boxbg" border="0"> 
        <tr class="bgbluegrey">
            <td colspan="3" align="center" >
                <asp:Label ID="lblQry" CssClass="blackfnt" 
                    Font-Bold="true" runat="server">
                    Update Cancellation Details
                </asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="width: 100px;">
                <asp:Label ID="lbl"  CssClass="blackfnt" Text="Enter Bill Cancellation Date" runat="server" Width="202px"></asp:Label>    
            </td>
            <td align="left" style="width: 40px;">
                <asp:TextBox ID="txtbilldt" Width="80px" runat="server"></asp:TextBox>
            </td>
            <td align="left" valign="top" width="500"> 
                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtbilldt, 'alnkdt', 'dd/MM/yyyy'); return false;" id="alnkdt">
                <img src="../../images/calendar.jpg" border="0" alt="" />
            </td>
            <tr style="background-color: white">
                <td align="left" >
                    <asp:Label ID="Label2" CssClass="blackfnt" runat="server">Cancellation Reason </asp:Label>
                </td>
                <td colspan="2" align="left" >
                    <asp:TextBox ID ="txtreson" runat="server" TextMode="multiLine" Width="200" ></asp:TextBox>
                </td>
            </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="0" width="100%">
        <tr bgcolor="white">
            <td>
                
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="0" width="100%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="bluefnt"><b>List Of Bills</b> </font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td>
                <table id="Table1" runat="server" border="0" cellpadding="0" cellspacing="0" class="boxbg" align="left" width="100%">
                    <tr id="Tr1" runat="server" bgcolor="white">
                        <td align="center">
                            <b><font color="red"><asp:Label ID="lblmsg" runat="server"></asp:Label></font></b>
                        </td>
                    </tr>
                    <tr id="Tr3" runat="server" bgcolor="white">
                        <td align="left">
                            <div align="left">
                                <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                    Width="100%" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false"
                                    EmptyDataText="No Records Found...">
                                    <Columns>
                                        <%--<asp:TemplateField HeaderText="Sr.No.">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" Width="3%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrno" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnbillno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField ControlStyle-Width="50px" >
                                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt"/>
                                            <HeaderTemplate>
                                                <input name="chkall" type="checkbox" onclick="Checkall(this);" value='ALL' >
                                            </HeaderTemplate>
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="3%"/>
                                            <ItemTemplate>
                                                <input type="checkbox" id="chkbillno" runat="server"  value='<%# DataBinder.Eval(Container.DataItem,"BILLNO")%>' />   
                                                <asp:HiddenField ID="hdnbilldt" Value='<%# DataBinder.Eval(Container.DataItem,"BGNDT2")%>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill No">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblbillno" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Generation Date">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="true" BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="10%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblbgndt" Text='<%# DataBinder.Eval(Container.DataItem,"BGNDT1") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Due Date">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="true" BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="10%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblduedt" Text='<%# DataBinder.Eval(Container.DataItem,"BDUEDT") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Branch">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="10%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblbillbranch" Text='<%# DataBinder.Eval(Container.DataItem,"BRANCH") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Party Name">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="30%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblpartynm" Text='<%# DataBinder.Eval(Container.DataItem,"PARTY") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Amount">
                                            <HeaderStyle HorizontalAlign="Center"  BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Width="5%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblbillamt"  Text='<%# DataBinder.Eval(Container.DataItem,"BILLAMT") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Status">
                                            <HeaderStyle HorizontalAlign="Center"  BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" Width="10%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblbillstatus" Text='<%# DataBinder.Eval(Container.DataItem,"BILLSTATUS") %>'
                                                    runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Type">
                                            <HeaderStyle HorizontalAlign="Center"  BackColor="#d4e0e7" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" Width="10%"/>
                                            <ItemTemplate>
                                                <asp:Label ID="lblbilltype" Text='<%# DataBinder.Eval(Container.DataItem,"BILLTYPE") %>'
                                                    runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnbilltype" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PAYBAS") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                     </tr>
                </table>
            </td>
         </tr>
     </table>         
     <br />
     <table cellspacing="1" class="boxbg" width="100%">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Button ID="Button1" runat="server" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                    Width="150px" OnClick="btnSubmit_Click" /></td>
                <asp:HiddenField ID="click_count" runat="server" Value="0" />   
        </tr>
     </table>
</div>
</ContentTemplate>
</asp:UpdatePanel>
<div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
</div>
</asp:Content>


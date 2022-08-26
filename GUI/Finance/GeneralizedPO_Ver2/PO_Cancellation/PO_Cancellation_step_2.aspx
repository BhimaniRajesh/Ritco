<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PO_Cancellation_step_2.aspx.cs" Inherits="GUI_Finance_Bill_MR_Cancellation_Bill_Cancellation_step_2"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

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
            var chkPOno;
            if(obj.checked == true)
            {
                for(i = 2; i <= Totalcount ; i++)
                {
                    if(i<10)
                    {  
                        chkPOno = document.getElementById(pref + "_ctl0" + i + "_chkPOno");
                    }
                    else
                    {  
                        chkPOno = document.getElementById(pref + "_ctl" + i + "_chkPOno");
                    }
                    chkPOno.checked = true;    
                }
            }
            else if(obj.checked == false)
            {
                for(i = 2; i <= Totalcount ; i++)
                {
                    if(i<10)
                    {  
                        chkPOno = document.getElementById(pref + "_ctl0" + i + "_chkPOno");
                    }
                    else
                    {  
                        chkPOno = document.getElementById(pref + "_ctl" + i + "_chkPOno");
                    }

                    chkPOno.checked = false;    
                }
            }
        }
        function CheckData()
        {
            var prefix = "ctl00_MyCPH1_"; 
            var grvcontrol = "ctl00_MyCPH1_grvcontrols";
            var txtPOdt = document.getElementById(prefix + "txtcandt");
            var txtreson = document.getElementById(prefix + "txtreson");
            var click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)

            if(txtPOdt.value == "")
            {
                alert("Please Enter PO Cancellation Date");
                txtPOdt.focus();
                return false;
            }
            if(!isValidDate(txtPOdt.value,"PO Cancellation"))
            {
                txtPOdt.value = "";
                txtPOdt.focus();
                return false;
            }
            var dateflag = CheckFinacialYear(txtPOdt,"PO Cancellation");
            if(!dateflag)
            return false;
        
            var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
            var Totalcount=tbl.rows.length;
            var chkPOno,hdnPOdt;
            var non=0;
            for(i = 2; i <= Totalcount ; i++)
            {
                if(i<10)
                {
                    hdnPOdt = document.getElementById(grvcontrol + "_ctl0" + i + "_hdnPOdt");
                    chkPOno = document.getElementById(grvcontrol + "_ctl0" + i + "_chkPOno");
                }
                else
                {
                    hdnPOdt = document.getElementById(grvcontrol + "_ctl" + i + "_hdnPOdt");
                    chkPOno = document.getElementById(grvcontrol + "_ctl" + i + "_chkPOno");
                }

                if(chkPOno.checked == true)
                {
                    non = 1;
                    var chq_dt = hdnPOdt.value
                    var voucher_dt = txtPOdt.value

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
                        alert("PO Cancellation Date Should Not Be Less than PO Generation Date!!!")
                        txtbilldt.value = "";
                        txtbilldt.focus();
                        return false;
                    }
                }
            }
            if(non == 0)
            {
                alert("Plz Select Atleast One PO Number!!!");
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
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                        -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                        background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                        opacity: .50; -moz-opacity: .50;" runat="server">
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
                        <font class="blackfnt"><a href=""><b><u>Exceptions </u></b></a>&gt; <a href=""><b><u>
                            Finance & Accounts</u></b></a>&gt; <a href=""><b><u>PO Cancellation</u></b></a></font>
                    </td>
                </tr>
            </table>
            <div align="left" style="width: 10in;">
                <table cellspacing="1" width="50%" align="center" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server"> Update Cancellation Details </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 100px;">
                            <asp:Label ID="lbl" CssClass="blackfnt" Text="Enter PO Cancellation Date" runat="server"
                                Width="202px"></asp:Label>
                        </td>
                        <td align="left" style="width: 40px;">
                            <asp:TextBox ID="txtcandt" Width="80px" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" valign="top" width="500">
                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtcandt, 'alnkdt', 'dd/MM/yyyy'); return false;"
                                id="alnkdt">
                                <img src="../../../images/calendar.jpg" border="0" alt="" />
                        </td>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" runat="server">Cancellation Reason </asp:Label>
                            </td>
                            <td colspan="2" align="left">
                                <asp:TextBox ID="txtreson" runat="server" TextMode="multiLine" Width="200"></asp:TextBox>
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
                            <b>List Of POs</b>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td>
                            <table id="Table1" runat="server" border="0" cellpadding="0" cellspacing="0" class="boxbg"
                                align="left" width="100%">
                                <tr id="Tr1" runat="server" bgcolor="white">
                                    <td align="center">
                                        <b>
                                            <asp:Label ID="lblmsg" runat="server"></asp:Label></b>
                                    </td>
                                </tr>
                                <tr id="Tr3" runat="server" bgcolor="white">
                                    <td align="left">
                                        <div align="left">
                                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                                Width="100%" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" EmptyDataText="No Records Found..."
                                                HeaderStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true" HeaderStyle-Wrap="false"
                                                HeaderStyle-HorizontalAlign="Center">
                                                <Columns>
                                                    <asp:TemplateField ControlStyle-Width="50px">
                                                        <HeaderTemplate>
                                                            <input name="chkall" type="checkbox" onclick="Checkall(this);" value='ALL'>
                                                        </HeaderTemplate>
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="3%" />
                                                        <ItemTemplate>
                                                            <input type="checkbox" id="chkPOno" runat="server" value='<%# DataBinder.Eval(Container.DataItem,"PONO")%>' />
                                                            <asp:HiddenField ID="hdnPOdt" Value='<%# DataBinder.Eval(Container.DataItem,"podate1")%>'
                                                                runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PO No">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPono" Text='<%# DataBinder.Eval(Container.DataItem,"PONO") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Manual PO No">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblManualPoNo" Text='<%# DataBinder.Eval(Container.DataItem,"ManualPoNo") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PO Date">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="10%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPODATE" Text='<%# DataBinder.Eval(Container.DataItem,"PODATE") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Vendor">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="25%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblvendor" Text='<%# DataBinder.Eval(Container.DataItem,"VENDORNAME") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PO Branch">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="25%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbllocation" Text='<%# DataBinder.Eval(Container.DataItem,"LOCATION") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Quantity">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblqty" Text='<%# DataBinder.Eval(Container.DataItem,"TOTALQTR") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Amount">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblamt" Text='<%# DataBinder.Eval(Container.DataItem,"TOTALAMT") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Pending Amount">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPendamt" Text='<%# DataBinder.Eval(Container.DataItem,"PENDAMT") %>'
                                                                runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PO Status">
                                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="15%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPOSTATUS" Text='<%# DataBinder.Eval(Container.DataItem,"POSTATUS") %>'
                                                                runat="server"></asp:Label>
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
                            <asp:Button ID="Button1" runat="server" OnClientClick="javascript:return CheckData();"
                                BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT" Width="150px" OnClick="btnSubmit_Click" />
                            <uc1:UserMessage ID="MsgBox" runat="server" />    
                        </td>
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

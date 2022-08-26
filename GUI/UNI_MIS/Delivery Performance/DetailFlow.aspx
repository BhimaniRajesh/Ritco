<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DetailFlow.aspx.cs" Inherits="Operation_DetailFlow" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
  
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
                 
             
              
              
              
             function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
    </script>

    <div align="left" style="width: 9in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Delivery Performance
                                Report</b></font>
                </td>
                 
            </tr>
        </table>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <table width="95%" id="taa1" runat="server" border="0" align="center" cellpadding="0"
                        cellspacing="0">
                        <tr>
                            <td>
                                <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <table width="100%" >
                                                <tr>
                                                    <td style="width: 39%;" valign="top">
                                                        <br />
                                                        <p align="center">
                                                            <label class="blackfnt">
                                                                <b>You Selected </b>
                                                            </label>
                                                        </p>
                                                        <%--<center>--%>
                                                        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                                                        </asp:GridView>
                                                        <table border="0" class="boxbg" cellspacing="1" cellpadding="5" width="565" 
                                                            id="san12" runat="server"  align="center"  >
                                                            <tr style="background-color: #ffffff">
                                                                <td style="height: 10px">
                                                                    <label class="blackfnt">
                                                                        Date :</label>
                                                                </td>
                                                                <td style="height: 10px">
                                                                    <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                            </tr>
                                                            <tr style="background-color: #FFFFFF">
                                                                <td style="width: 205">
                                                                    <label class="blackfnt">
                                                                        Location :</label></td>
                                                                <td style="width: 343">
                                                                    &nbsp;
                                                                    <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="background-color: #ffffff">
                                                                <td style="height: 6px">
                                                                    <label class="blackfnt">
                                                                        Status:</label>
                                                                </td>
                                                                <td style="height: 6px">
                                                                    &nbsp;<asp:Label ID="lblstatus" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                            </tr>
                                                        </table>
                                                        <%--</center>--%>
                                                        <br />
                                                        <br />
                                                        <center>
                                                            <table border="0" cellpadding="5" width="565"  
                                                                id="san1" runat="server" cellspacing="1" align="center" class="boxbg">
                                                                <tr class="bgbluegrey">
                                                                    <td style="width: 10%; height: 67px;">
                                                                        <label class="blackfnt">
                                                                            Sr. No</label></td>
                                                                    <td style="width: 1736px; height: 67px">
                                                                        <label class="blackfnt">
                                                                            <%=Session["DocketCalledAs"] %> number</label></td>
                                                                    <td style="width: 640px; height: 67px">
                                                                        <label class="blackfnt">
                                                                            Dely. Location&nbsp;</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            Consignor</label></td>
                                                                    <td style="width: 46px; height: 67px;">
                                                                        <label class="blackfnt">
                                                                            Consignee&nbsp;</label></td>
                                                                    <td style="width: 10%; height: 67px;">
                                                                        <label class="blackfnt">
                                                                            <%=Session["DocketCalledAs"] %> Date</label></td>
                                                                    <td style="width: 41px; height: 67px;">
                                                                        <label class="blackfnt">
                                                                            <%=Session["DocketCalledAs"] %> Entry. Date</label></td>
                                                                    <td style="width: 300px; height: 67px">
                                                                        <label class="blackfnt">
                                                                            Comm. Dely. Date</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            Last Location&nbsp;</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            &nbsp;Dep. Date</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            Current Location</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            Actual Location&nbsp;</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            Pkgs. No.</label></td>
                                                                    <td style="width: 151px; height: 67px">
                                                                        <label class="blackfnt">
                                                                            Charge Wt.</label></td>
                                                                    <td style="width: 151px; height: 67px">
                                                                        <label class="blackfnt">
                                                                            Arrival Date</label></td>
                                                                    <td style="width: 151px; height: 67px">
                                                                        <label class="blackfnt">
                                                                            Dely. Date</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            &nbsp;DRS No.</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            &nbsp;DRS Date</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            &nbsp;Diff. hrs</label></td>
                                                                    <td style="height: 67px">
                                                                        <label class="blackfnt">
                                                                            &nbsp;DRS Update Date</label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Repeater ID="rptBillDetails" runat="server">
                                                                            <ItemTemplate>
                                                                                <tr style="background-color: White">
                                                                                    <td style="width: 198px">
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "dockno")%>
                                                                                            </a>
                                                                                        </label>
                                                                                        <%--<label class="blackfnt">
                                                                                         
                                                                                            <asp:HyperLink  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# "./../MR_Details.aspx"%>' 
                                                                                                Runat="server" Target="_blank" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                                                                     ID="Hyperlink2" />
                                                                                        </a>
                                                                                    </label>--%>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "dly_loc")%>
                                                                                            </a>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "csgnnm")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "csgenm")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "dockdt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "docdt_entry")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "cdeldt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "last_loc")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "dep_dt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "curr_loc")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "dly_loc")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "pkgsno")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "chrgwt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "arrv_dt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "dely_dt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "pdcno")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "pdcdt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "diff_days")%>
                                                                                        </label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <label class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "pdcdt_attempt")%>
                                                                                        </label>
                                                                                    </td>
                                                                                </tr>
                                                                            </ItemTemplate>
                                                                        </asp:Repeater>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <%--Table for displaying no records found message--%>
                                                            <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080"
                                                                align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
                                                                <tr style="background-color: #FFFFFF">
                                                                    <td colspan="22" align="right" style="width: 892px">
                                                                        <div align="center">
                                                                            <label style="color: #FF0000;" class="blackfnt">
                                                                                No Record Found
                                                                            </label>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </center>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table border="0" align="center" cellpadding="0" cellspacing="4" id="tblPageNavigation"
                                                runat="server">
                                                <tr align="center">
                                                    <td align="center">
                                                        <br />
                                                        <br />
                                                        <label class="blackfnt">
                                                            Page&nbsp;
                                                            <asp:Label ID="CurrentPage" CssClass="blackfnt" runat="server" />
                                                            &nbsp;of&nbsp;
                                                            <asp:Label ID="TotalPages" CssClass="blackfnt" runat="server" />
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td align="center">
                                                        <label class="blackfnt">
                                                            <asp:LinkButton runat="server" CssClass="blackfnt" ID="FirstPage" Text="[First Page]"
                                                                OnCommand="NavigationLink_Click" CommandName="First" />
                                                            <asp:LinkButton runat="server" CssClass="blackfnt" ID="PreviousPage" Text="[Previous Page]"
                                                                OnCommand="NavigationLink_Click" CommandName="Prev" />
                                                            <asp:LinkButton runat="server" CssClass="blackfnt" ID="NextPage" Text="[Next Page]"
                                                                OnCommand="NavigationLink_Click" CommandName="Next" />
                                                            <asp:LinkButton runat="server" CssClass="blackfnt" ID="LastPage" Text="[Last Page]"
                                                                OnCommand="NavigationLink_Click" CommandName="Last" />
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td align="center">
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <center>
                                                <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" id="tblButtons"
                                                    runat="server">
                                                    <tr style="background-color: #ffffff">
                                                    </tr>
                                                </table>
                                            </center>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td colspan="2" style="background-color: #ffffff" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

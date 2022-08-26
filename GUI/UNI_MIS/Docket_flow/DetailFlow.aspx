<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DetailFlow.aspx.cs" Inherits="Operation_DetailFlow" %>

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

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Docket Flow Report
                        </b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br /><br /><br />
    <div align="left" runat="server" style="width: 10in">
        <table border="0" cellpadding="3" width="565" style="background-color: #808080;"
            cellspacing="1" align="center" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td style="width: 205">
                    <label class="blackfnt">
                        Date :</label></td>
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
            <tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 6px;">
                    <label class="blackfnt">
                        Customer :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td style="width: 205">
                    <label class="blackfnt">
                        Status :</label></td>
                <td style="height: 6px">
                    &nbsp;<asp:Label ID="lblstatus" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
        </table>
        <%--</center>--%>
        <br />
        <br />
        <center>
            <table border="1" style="background-color: #FFFFFF; width: 9.5in;" align="left" cellspacing="0"
                cellpadding="1" runat="server" id="newtab" class="boxbg">
                <tr>
                    <td>
                        <tr class="bgbluegrey">
                            <td style="width: 4%; height: 67px;">
                                <label class="blackfnt">
                                    Sr. No</label></td>
                            <td style="width: 1036px; height: 67px">
                                <label class="blackfnt">
                                    Docket number</label></td>
                            <td style="width: 640px; height: 67px">
                                <label class="blackfnt">
                                    Dely. Location&nbsp;</label></td>
                            <td style="height: 67px">
                                <label class="blackfnt">
                                    Consignor</label></td>
                            <td style="width: 46px; height: 67px;">
                                <label class="blackfnt">
                                    Consignee&nbsp;</label></td>
                            <td style="width: 300px; height: 67px;">
                                <label class="blackfnt">
                                    Bkg. Date</label></td>
                            <td style="width: 300px; height: 67px">
                                <label class="blackfnt">
                                    Comm. Dely. Date</label></td>
                            <td style="height: 67px">
                                <label class="blackfnt">
                                    Last Location&nbsp;</label></td>
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
                        </tr>
                        <%-- <tr>
                <td style="width: 4%; height: 67px;">--%>
                        <asp:Repeater ID="rptBillDetails" runat="server">
                            <ItemTemplate>
                                <tr style="background-color: White">
                                    <td style="width: 198px">
                                        <label class="blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                        </label>
                                    </td>
                                    <%--<td>
                                                                                    <label class="blackfnt">
                                                                                         
                                                                                            <asp:HyperLink  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# "./../MR_Details.aspx"%>' 
                                                                                                Runat="server" Target="_blank" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                                                                     ID="Hyperlink2" />
                                                                                        </a>
                                                                                    </label>
                                                                                </td>--%>
                                    <td>
                                        <label class="blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "dockno")%>
                                            </a>
                                        </label>
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
                                            <%#DataBinder.Eval(Container.DataItem, "cdeldt")%>
                                        </label>
                                    </td>
                                    <td>
                                        <label class="blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "last_loc")%>
                                        </label>
                                    </td>
                                    <%-- <td>
                                                                                    <label class="blackfnt">
                                                                                         <%#DataBinder.Eval(Container.DataItem, "dep_dt")%>
                                                                                    </label>
                                                                                </td>--%>
                                    <td>
                                        <label class="blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "curr_loc")%>
                                        </label>
                                    </td>
                                    <td>
                                        <label class="blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "dly_loc1")%>
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
                                            <%#DataBinder.Eval(Container.DataItem, "dely_dt").ToString()%>
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
        </td> </tr> </table>
        <br />
        <br />
        <table border="0" align="center" cellpadding="0" cellspacing="4" id="tblPageNavigation"
            runat="server">
            <tr align="center">
                <td align="center">
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
            <tr>
                <td align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
        <br />
        <%-- <center>
                                                    <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Print  " runat="server" id="btnPrint" onclick="faction(1)" />
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  XLS  " runat="server" id="btnXML" onclick="faction(2)" />
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Email " runat="server" id="btnEmail" onclick="faction(3)" />
			                                                </td>
			                                            </tr>
		                                            </table>
		                                        </center>--%>
    </div>
</asp:Content>

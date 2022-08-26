<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_DocFlow.aspx.cs" Inherits="DOC_FLOW_Show_DocFlow" %>

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
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=docketis%> Flow Report
                        </b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table border="0" style="background-color: #808080; width: 9.5in;" cellspacing="0"
        align="left" class="boxbg">
        <tr bgcolor="#ffffff">
            <td align="center">
                <label class="blackfnt">
                    You Selected</label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <br />
                <br />
                <table border="0" cellpadding="3" width="565" style="background-color: #808080;"
                    cellspacing="1" align="center" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date :</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                                RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
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
                                Customer Code :</label></td>
                        <td style="width: 343; height: 6px;">
                            &nbsp;
                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Date Type : :</label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lbldt" runat="server" CssClass="blackfnt">
                                                    Date Wise</asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Flow Type :
                            </label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                                                    Flow</asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <br />
                <br />
                <table border="0" style="width: 9.5in;" cellspacing="1" cellpadding="5" runat="server"
                    id="newtab" class="boxbg">
                    <tr class="bgbluegrey">
                        <td style="width: 3%;">
                            <label class="blackfnt">
                                Sr. No</label></td>
                        <td style="width: 1306px; height: 67px">
                            <label class="blackfnt">
                                Location</label></td>
                        <td style="width: 440px; height: 67px">
                            <label class="blackfnt">
                                Total <%=docketis%> Booked&nbsp;</label></td>
                        <td style="height: 67px">
                            <label class="blackfnt">
                                Left Starting Location</label></td>
                        <td style="width: 46px; height: 67px;">
                            <label class="blackfnt">
                                Not Left Starting Location&nbsp;</label></td>
                        <td style="width: 150px; height: 67px;">
                            <label class="blackfnt">
                                Arrived at Dely. Loc</label></td>
                        <td style="width: 100px; height: 67px">
                            <label class="blackfnt">
                                Not Arrived at Dely. Loc</label></td>
                        <td style="height: 67px">
                            <label class="blackfnt">
                                Delivery Attempted&nbsp;</label></td>
                        <td style="height: 67px">
                            <label class="blackfnt">
                                &nbsp;Delivery Not Attempted</label></td>
                        <td style="height: 67px">
                            <label class="blackfnt">
                                Delivered In-Time</label></td>
                        <td style="height: 67px">
                            <label class="blackfnt">
                                Delivered late&nbsp;</label></td>
                        <td style="height: 67px">
                            <label class="blackfnt">
                                Part Delivered</label></td>
                        <td style="width: 151px; height: 67px">
                            <label class="blackfnt">
                                Failed Delivery</label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Repeater ID="rptBillDetails" runat="server" OnItemDataBound="rpt">
                                <ItemTemplate>
                                    <tr style="background-color: White">
                                        <td style="width: 198px">
                                            <label class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                            </label>
                                        </td>
                                        <td style="width:3in">
                                            <label class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "locname")%>
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink runat="server" Font-Underline="True" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"1"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "TOTALDOCKETS")%>' ID="Hyperlink1" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"2"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "LEFT_TOTDKTS")%>' ID="Hyperlink2" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"2a"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "NOTLEFT_TOTDKTS")%>' ID="Hyperlink3" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"3"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "ARRV_TOTDKTS")%>' ID="Hyperlink4" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"3a"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "NOTARRV_TOTDKTS")%>' ID="Hyperlink5" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"4"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "DLYATTEMPT_TOTDKTS")%>' ID="Hyperlink6" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"4a"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "NOTDLYATTEMPT_TOTDKTS")%>' ID="Hyperlink7" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"5"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "DLYINTIME_TOTDKTS")%>' ID="Hyperlink8" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"6"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "DLYLATE_TOTDKTS")%>' ID="Hyperlink9" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"6a"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "PARTDLY_TOTDKTS")%>' ID="Hyperlink10" />
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"7"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "UNDLY_TOTDKTS")%>' ID="Hyperlink11" />
                                            </label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <%--Table for displaying no records found message--%>
                <br />
                <br />
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
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <br />
                <table style="width: 10.5in;" align="left" cellpadding="1" cellspacing="3" id="tblPageNavigation"
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
                            <br />
                            <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

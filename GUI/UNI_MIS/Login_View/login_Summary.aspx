<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="login_Summary.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
   <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b> <font class="blklnkund"><b>Special
                        Reports</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Login View Report</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div align="left" style="width: 9in">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="5" width="565"  
                        cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :
                                </label>
                            </td>
                            <td style="height: 10px">
                                 &nbsp; <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
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
                                    Employee :</label></td>
                            <td style="width: 343; height: 6px;">
                                &nbsp;
                                <asp:Label ID="lblemp" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Login Instance &gt;=
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblli" runat="server" CssClass="blackfnt">
                                </asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br /><br />
                </td>
            </tr>
            <tr>
            
                <asp:GridView ID="GV_S" runat="server" Width="800" align="center" BorderWidth="0" CellPadding="5"  CellSpacing="1"
                     HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg"  FooterStyle-CssClass="boxbg" AllowPaging="true"
                    PageSize="25" AutoGenerateColumns="false" OnPageIndexChanging="pgChange" AllowSorting="False"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:BoundField  DataField="EMPCD" HeaderStyle-Font-Bold="true" HeaderText="Employee Code">
                            <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  HorizontalAlign="left" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EMPNM" HeaderStyle-Font-Bold="true" HeaderText="Employee Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:BoundField>
                        <%-- <asp:BoundField  DataField="NOOFLOGIN"   HeaderText="No. Of Times Login" > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>--%>
                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="No. Of Times Login">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:HyperLink Font-Underline="True" CssClass="Blackfnt" runat="server" NavigateUrl='<%#"Login_2_2.aspx?strDateRange=" +Request.QueryString["strDateRange"].ToString()+ "&strloc=" + "" + "&stremp=" +DataBinder.Eval(Container.DataItem, "EMPCD")+"&strlogininstence=" + "" + "&strreptype="+"A"%>'
                                    Text='<%#DataBinder.Eval(Container.DataItem, "NOOFLOGIN")%>' ID="Hyperlink2" />
                                <font cssclass="Blackfnt"></a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label>
            </tr>
            <tr align="center">
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <table border="0" cellpadding="0" width="565" style="background-color: #808080;"
            cellspacing="0" align="center" class="boxbg">
            <tr align="center">
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                    </asp:LinkButton>
                </td>
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                    </asp:LinkButton>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td style="height: 6px">
                </td>
                <td style="height: 6px">
                    &nbsp;
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt">
                    </asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="background-color: #ffffff" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossingChallanView2.aspx.cs" Inherits="GUI_Operations_Crossing_ViewPrint_CrossingChallanView2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
            window.open("../ViewCrossingChallan.aspx?CrossingChallanNo=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
            
        }
    </script>

    <div align="center">
        <form id="form1">
            <div align="left">
                <p align="left">
                    <font class="blackfnt"><b>You Selected</b></font></p>
                <table border="0" cellpadding="3" cols="1" style="width: 9.5in" bgcolor="#808080"
                    cellspacing="1" align="left" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td width="205" align="left">
                            <div align="left">
                                <font class="blackfnt">Crossing Challan Date</font></div>
                        </td>
                        <td width="343" align="left">
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font></div>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="205" align="left">
                            <div align="left">
                                <font class="blackfnt">Crossing Challan No</font>
                            </div>
                        </td>
                        <td width="343" align="center">
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocNo" runat="server" Text="Label"></asp:Label></font></div>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <br />
                <br />
                <p align="left">
                    <font class="blackfnt"><b>Crossing Challan List</b></font></p>
                <br />
                <asp:GridView ID="GridCrossingList" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                    AllowSorting="true" AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnPageIndexChanging="pgChange" EmptyDataText="No Records Found..." Style="width: 9.5in">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                Crossing Challan No</HeaderTemplate>
                            <HeaderStyle CssClass="blckfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <center>
                                    <a href="javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"CrossingChallanNo") %>','0')">
                                        <%# DataBinder.Eval(Container.DataItem, "CrossingChallanNo")%>
                                    </a>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ChallanDate" HeaderText="Challan Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vendname" HeaderText="Vendor Name ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ChallanLocCode" HeaderText="Branch">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField>
                        <headertemplate>
                                Print</headertemplate>
                        <headerstyle cssclass="blckfnt" horizontalalign="Center" />
                        <itemtemplate>
                                <center>
                                    <a href="javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"CrossingChallanNo") %>','1')">
                                        <font class="blackfnt">Print</font></a>
                                </center>
                            </itemtemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
            </div>
            <br />
            <asp:HiddenField ID="txtdocketlist" runat="server" />
            <asp:HiddenField ID="txtdocketlist_count" runat="server" />
            <div align="left">
                <%--<asp:Button ID="Button1" runat="server"  CssClass="blackfnt" Text="Submit" OnClick="Button1_Click" />--%>
            </div>
        </form>
    </div>
</asp:Content>

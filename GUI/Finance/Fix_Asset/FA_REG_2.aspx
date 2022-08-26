<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FA_REG_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>FA REGISTER </b></font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        
        <%--       <center>
        <asp:Label ID="Label2" runat="server" ForeColor="red" Font-Size="X-Large" Font-Bold="true" Text="UNDER MAINTAINSSANCE....." CssClass="blackfnt"></asp:Label>
      </center>--%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="3" width="565" cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :
                                </label>
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
                                <asp:Label ID="lblloc" Text="All" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 6px;">
                                <label class="blackfnt">
                                    Asset Group:</label></td>
                            <td style="width: 343; height: 6px;">
                                &nbsp;
                                <asp:Label ID="lblgrp" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
         
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="4"
            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
            CellSpacing="1" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
            OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
            ShowFooter="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
            EmptyDataText="No Records Found...">
            <PagerStyle VerticalAlign="Bottom" />
            <Columns>
                <asp:BoundField DataField="allotcd" ItemStyle-Wrap="true" HeaderText="Allocate No."
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="asset_name" ItemStyle-Wrap="true" HeaderText="Asset Name"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="dt1" ItemStyle-Wrap="true" HeaderText="Installation Date"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="group_name" ItemStyle-Wrap="true" HeaderText="Classification"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="description_detail" ItemStyle-Wrap="true" HeaderText="Description"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="" ItemStyle-Wrap="true" HeaderText="Depriciate Rate(%) "
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="gross_val" ItemStyle-Wrap="true" HeaderText="Gross Value"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="" ItemStyle-Wrap="true" HeaderText="Deprciation Amount"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="" ItemStyle-Wrap="true" HeaderText="Net Value" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="loccode" ItemStyle-Wrap="true" HeaderText="Current Location"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="next_loccode" ItemStyle-Wrap="true" HeaderText="Assign Location"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="true" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="assgnempcd" ItemStyle-Wrap="true" HeaderText="Assigned To Employee"
                    HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                    <ItemStyle Width="150" BackColor="white" Wrap="true" HorizontalAlign="Center" CssClass="blackfnt" />
                </asp:BoundField>
                <%--       <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Assign" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <label class="blackfnt">
                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"Goods_RCPT_3.aspx?para1=2&pcd="+DataBinder.Eval(Container.DataItem, "pocode")%>'
                                    Text='Assign' ID="Hyperlink3" />
                            </label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
            ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
        <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
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
            <tr align="center">
            </tr>
        </table>
        <br />
        <br />
        <center>
            <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
        </center>
         <br />
        <br />
    </div>
</asp:Content>

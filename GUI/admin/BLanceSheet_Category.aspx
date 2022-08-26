<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BLanceSheet_Category.aspx.cs" Inherits="GUI_admin_BLanceSheet_Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 8.0in">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Set Balance Sheet Category.</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                
                
            </td>
        </tr>
         <tr style="background-color: white">
            <td align="left"><%--<asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" runat="server">
                                        <ContentTemplate>
                                            <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressArea">
                                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>--%></td>
        </tr>
    </table>
    <br />
    <div align="left">
        <asp:UpdatePanel ID="UpdatePanel5"  UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 8.0in" class="boxbg" border="0">
                    <tr style="background-color: white">
                        <td align="center">
                            <table cellspacing="1" style="width: 4.0in" class="boxbg" border="0">
                                <tr style="background-color: white">
                                    <td align="left">
                                        <fort class="blackfnt"> Select  Category </fort>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList runat="server" CssClass="blackfnt" ID="Balcat"  AutoPostBack="true" OnSelectedIndexChanged="Balcat_SelectedIndexChanged">
                                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                             <asp:ListItem Text="ASSET" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="LIABILITY" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                        
                                    </td>
                                </tr>
                            </table>
                             <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressArea">
                                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                       <asp:Label ID="lblStatus"  runat="server" CssClass="redfnt"  Text="" Visible="false"  ></asp:Label>     
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" CellSpacing="1" CellPadding="3"
                                PagerStyle-HorizontalAlign="left" ShowFooter="True"  CssClass="boxbg" BorderWidth="0"
                                AutoGenerateColumns="False"  OnRowDataBound="GV_D_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                            </asp:Label>
                                            <asp:HiddenField ID="SRNO" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:BoundField DataField="groupdesc" HeaderText="Group">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <%--<asp:TemplateField HeaderText="SR.NO.">
                                        <ItemTemplate>
                                        
                                            <asp:CheckBox ID="ChkCat1" runat="server" class="input" />
                                            <asp:Label ID="lblChkCat1"  runat="server"  Text='<%#DataBinder.Eval(Container.DataItem, "CAT1")%>' Visible="false"  ></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="ChkCat2" runat="server" class="input" />
                                            <asp:Label ID="lblChkCat2"  runat="server"  Text='<%#DataBinder.Eval(Container.DataItem, "CAT2")%>' Visible="false"  ></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:TemplateField>--%>
                                      <asp:TemplateField HeaderText="Select Balance Sheet Category">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DLLBalCat" runat="server" CssClass="blackfnt"  ></asp:DropDownList>
                                            <asp:Label ID="lblChkCat2"  runat="server"  Text='<%#DataBinder.Eval(Container.DataItem, "bstype")%>' Visible="false"  ></asp:Label>
                                            <asp:Label ID="lblgroupcode"  runat="server"  Text='<%#DataBinder.Eval(Container.DataItem, "groupcode")%>' Visible="false"  ></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="bgbluegrey" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr id="TR1" runat="server"  style="background-color: white;display:none;">
                        <td align="center">
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click"  CssClass="blackfnt" Text="Submit" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

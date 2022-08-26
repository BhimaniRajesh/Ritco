<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OctroiDocketDetails.ascx.cs" Inherits="GUI_Octroi_New_OctroiDocketDetails" %>
<asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
    <ContentTemplate>
        <div style="width: 800px; text-align: center">
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                <tr style="background-color: White">
                    <td style="text-align: center" class="blackfnt">
                        &nbsp;Enter No. of Rows
                    </td>
                    <td style="text-align: left" class="blackfnt">
                         <asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" onkeypress="javascript:validInt(event);" CssClass="input" Width="100px"></asp:TextBox>
                         <asp:Button ID="btnAdd" runat="server" Text="Submit"  OnClick="btnAdd_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="100%">
            <tr style="background-color: White">
                <td style="text-align: center" class="blackfnt">
                       <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                            CellSpacing="1" CssClass="boxbg" 
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                            PagerStyle-HorizontalAlign="left" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No.">
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               <asp:TemplateField>
                                    <HeaderTemplate><%=Session["DocketCalledAs"].ToString()%><br /> No</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDockno" runat="server" BorderStyle="Groove" CssClass="input" Enabled="true" Width="100px" onblur="javascript:return DocketCheck(this)" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Octroi Amount</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOctAmt"  runat="server" BorderStyle="Groove" CssClass="input" Width="100px" Text="0.00" style="text-align:right" onkeypress="javascript:validInt(event);" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Octroi Reciept No</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRecpno" runat="server" BorderStyle="Groove" CssClass="input" Width="100px" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Octroi Reciept Date</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRecpdt" runat="server" BorderStyle="Groove" onblur="javascript:ValidateDate(this)" CssClass="input" Width="100px" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle Wrap="True" />
                        </asp:GridView>    
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
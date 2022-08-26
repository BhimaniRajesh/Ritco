<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OctroiBillDetailsControl.ascx.cs" Inherits="GUI_Octroi_New_OctroiBillDetailsControl" %>
<script language="javascript" type="text/javascript">
</script>
<asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
    <ContentTemplate>
        <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="910">
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    <input type="checkbox" id="svrtax_yn" runat="server" checked="checked" onclick="javascript:return calc()" />
                    <strong><span style="color: #ff0000">Check here to Enable Service tax Deatils for the Octroi BIll detail</span></strong>
                </td>
            </tr>
        </table>
        <br />
        <div style="width: 890px; text-align: center">
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                <tr style="background-color: White">
                    <td style="text-align: center" class="blackfnt">
                        &nbsp;Enter No. of Rows
                    </td>
                    <td style="text-align: left" class="blackfnt">
                                <asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" onkeypress="javascript:validInt(event);" CssClass="input" Width="100px" Text="5"></asp:TextBox>
                                <asp:Button ID="btnAdd"  CssClass="blackfnt"  runat="server" Text="Submit"  OnClick="btnAdd_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="810">
            <tr style="background-color: White">
                <td style="text-align: center" class="blackfnt">
                       <asp:GridView ID="grvcontrols" runat="server"  CellPadding="2" AutoGenerateColumns="False" BorderWidth="0px"
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
                                    <HeaderTemplate>Docket<br /> No</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDockno" runat="server" BorderStyle="Groove" CssClass="blackfnt" Enabled="true" Width="60px" onblur="javascript:return DocketCheck(this)" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Declared<br />Value</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDelVal"  runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="60px" Enabled="false" Text="0.00" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Octroi<br />Amt</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOctAmt" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="60px" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Octroi(%)">
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOctper" Enabled="false" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()" BorderStyle="Groove" CssClass="blackfnt" Width="50px" MaxLength="6"  Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Clearance<br />Charges</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtClearChrg" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="60px" Text="0.00" MaxLength="10" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"  onblur="javascript:return calc()" ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Processing<br /> Charges(%)</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtProPercent" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return Porcess_Chrg_calc(this)"  runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="50px" MaxLength="6"  Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Processing<br /> Charges</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtProChrg"  Enabled="true" runat="server"   onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"  BorderStyle="Groove" CssClass="blackfnt" Width="60px" MaxLength="10"  Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Other<br /> Charges</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOtrChrg" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()" Text="0.00" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="60px" MaxLength="10" ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Service<br /> Tax</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSvrTax" Enabled="false" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="50px" MaxLength="10"  Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cess">
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtCess"  Enabled="false" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="50px" MaxLength="10" Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Higher<br /> Edu. Cess</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtHEduCess" Enabled="false" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="50px" MaxLength="10" Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total">
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTotal" Enabled="false" runat="server" BorderStyle="Groove" CssClass="blackfnt" Text="0.00" Width="60px" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Reciept<br /> No</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRecpno" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="60px" MaxLength="10"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>Reciept<br /> Date</HeaderTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRecpdt" runat="server" BorderStyle="Groove" onblur="javascript:ValidateDate(this)" CssClass="blackfnt" Width="60px" MaxLength="10"></asp:TextBox>
                                        <asp:HiddenField ID="hdndockdt" Value="" runat="server" />
                                        
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
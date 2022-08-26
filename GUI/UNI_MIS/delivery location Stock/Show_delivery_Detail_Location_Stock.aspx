<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_delivery_Detail_Location_Stock.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div style="width: 10in">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Delivery Location
                                Stock Report</b></font>
                </td>
            </tr>
        </table>
        <table align="center" style="width: 3.5in">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table width="100%" border="0" cellspacing="1" cellpadding="5" class="boxbg">
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
                            <td style="width: 205; height: 6px;">
                                <label class="blackfnt">
                                    Ro :</label></td>
                            <td style="width: 343; height: 6px;">
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
                    </table>
                </td>
            </tr>
            <tr>
                <br />
                <br />
                <br />
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Dtl" runat="server" align="center" BorderWidth="0" CellSpacing="1"
                    CellPadding="5" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                    OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <%--<asp:BoundField  DataField="Sno"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblhdr3" Text='<%#Session["DocketCalledAs"]+ " Org."%> ' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                            <ItemTemplate>
                                <center>
                                    <label class="blackfnt">
                                        <asp:Label ID="lblhdr24" Text='<%#DataBinder.Eval(Container.DataItem, "orgncd")%>'
                                            runat="server"></asp:Label>
                                    </label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblhdr" Text='<%#Session["DocketCalledAs"]+ " No."%> ' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                            <ItemTemplate>
                                <center>
                                    <label class="blackfnt">
                                        <asp:Label ID="lblhdr2" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                            runat="server"></asp:Label>
                                    </label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--  <asp:BoundField  DataField="d1"   ItemStyle-Wrap="true"  HeaderText="Docket date"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                        <asp:BoundField DataField="report_loc" ItemStyle-Wrap="true" HeaderText="Delivery Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <%-- <asp:BoundField  DataField="d2"   ItemStyle-Wrap="true"  HeaderText="Arrival date"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                        <%-- 
                                                                             <asp:BoundField  DataField="booked"   ItemStyle-Wrap="true"  HeaderText="Booked"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             <asp:BoundField  DataField="arrived"   ItemStyle-Wrap="true"  HeaderText="Arrived"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
               <%--         <asp:BoundField DataField="paybas" ItemStyle-Wrap="true" HeaderText="Frt. Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>--%>
                        
                        <asp:BoundField DataField="actuwt" ItemStyle-Wrap="true" HeaderText="Act.Wt.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dkttot" ItemStyle-Wrap="true" HeaderText="Value">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="csgnnm" ItemStyle-Wrap="false" HeaderText="Consignor">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="csgenm" ItemStyle-Wrap="false" HeaderText="Consignee">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <%--        
                                                                             <asp:BoundField   ItemStyle-Wrap="true" DataFormatString="All" HeaderText="Delivery Type"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                        <asp:BoundField DataField="freight" ItemStyle-Wrap="true" HeaderText="Freight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="detained" ItemStyle-Wrap="true" HeaderText="Detained">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <%--<a href="Login_2_2.aspx?strDateRange=" +'<%#Request.QueryString["strDateRange"]%>'>                                   
                                        
                                         <asp:HyperLink  Font-Underline="True"  ForeColor="#000099"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"2"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>' Text= '<%#DataBinder.Eval(Container.DataItem, "LEFT_TOTDKTS")%>' ID="Hyperlink2"/>



   <%#DataBinder.Eval(Container.DataItem, "totdkt")%>                                 
                                           <font cssclass="Blackfnt">
                                        </a>--%>
                        <%-- <asp:TemplateField HeaderText="Undue ">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&reppara="+"1"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "totdkt")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                
--%>
                        <%--  <asp:BoundField  DataField="totdkt"  > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>--%>
                        <%--<asp:BoundField  DataField="Quickdkt"    > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>--%>
                        <%-- <asp:TemplateField HeaderText="Undue ">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&reppara="+"2"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "Quickdkt")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>--%>
                        <%--  <asp:BoundField  DataField="Operdkt"    > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>
                                                                               --%>
                        <%-- <asp:TemplateField HeaderText="Undue ">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&reppara="+"3"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "Operdkt")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>--%>
                        <%-- <asp:BoundField  DataField="Findkt"    > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>--%>
                        <%--                                                                               <asp:TemplateField HeaderText="Undue ">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>--%>
                        <%-- <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&reppara="+"4"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "Findkt")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>--%>
                        <%-- <asp:BoundField  DataField="per1"  > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="per2"  > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="TotalChgWt"    > 
                                                                            <HeaderStyle HorizontalAlign="Center"  Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                                             </asp:BoundField>--%>
                    </Columns>
                </asp:GridView>
                <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
            </tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
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
            <tr align="center">
                <td colspan="2" style="background-color: #ffffff">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="DownLoad XLS"
                        Width="139px" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

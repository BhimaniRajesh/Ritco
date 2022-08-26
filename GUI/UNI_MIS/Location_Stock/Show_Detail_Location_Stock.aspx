<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_Detail_Location_Stock.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Location Stock Report
                        </b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <div align="left" style="width: 9.5in;">
        <table width="100%">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="5" width="565" cellspacing="1" align="center" class="boxbg">
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
                                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Delivery Type :</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lbldlytyp" runat="server" Text="All" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Report Type :</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblreptyp" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
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
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <table style="width: 1100px">
            <tr>
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Dtl" runat="server" align="center" BorderWidth="0" CellPadding="5"
                    HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CellSpacing="1"
                    CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                    ShowFooter="true" FooterStyle-BackColor="white" OnPageIndexChanging="pgChange"
                    AllowSorting="False" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                         <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="Label2" Text='<%# Session["DocketCalledAs"] +" Org" %>' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" Text='<%#DataBinder.Eval(Container.DataItem, "orgncd")%>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="Label2" Text='<%# Session["DocketCalledAs"] +" No." %>' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    
                        
                        
                         <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="Label2" Text='<%# Session["DocketCalledAs"] +" date" %>' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="false" CssClass="blackfnt" />
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="white" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" Text='<%#DataBinder.Eval(Container.DataItem, "dockdt")%>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                      
                    <%--    <asp:BoundField DataField="dockdt" ItemStyle-Wrap="true" HeaderText="Docket date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>--%>
                        
                           <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="Label2" Text='<%# Session["DocketCalledAs"] +" Dely." %>' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" Text='<%#DataBinder.Eval(Container.DataItem, "destcd")%>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                           <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="Label2" Text='<%# Session["DocketCalledAs"] +"Arrive. date" %>' runat="server"></asp:Label>
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" Text='<%#DataBinder.Eval(Container.DataItem, "arr_date")%>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                     
                         
                        <asp:BoundField DataField="paybas" ItemStyle-Wrap="true" HeaderText="Frt. Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        
                        <asp:BoundField DataField="actuwt" ItemStyle-Wrap="true" HeaderText="Actual Weight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dkttot" ItemStyle-Wrap="true" HeaderText="Value">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="csgnnm" ItemStyle-Wrap="true" HeaderText="Consignor">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="csgenm" ItemStyle-Wrap="true" HeaderText="Consignee">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <%-- <asp:BoundField   ItemStyle-Wrap="true"  HeaderText="Delivery Type"   > 
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
                <td colspan="2" style="height: 24px; background-color: #ffffff">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="DownLoad XLS"
                        Width="139px" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Show_CreditResult.aspx.cs" Inherits="DOC_FLOW_Show_DocFlow" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 

     

        
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
        


 
           
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="height: 30">
                                                <asp:HyperLink ID="hypWelcome" runat="server">        
                                                </asp:HyperLink>
                                                    <%--<a href="../../welcome.asp">
                                                        <font class=blklnkund><strong><%=session("MainLevel_Type")%> Module</strong></font></a>--%>
                                                <strong> &gt; </strong>
                                                <asp:HyperLink ID="hypReport" runat="server">
                                                </asp:HyperLink>
                                                    <%--<a href="../reportmenu.asp"><font class=blklnkund><strong>Reports</strong></font></a>--%>
                                                <strong> &gt; </strong>
                                                <asp:HyperLink ID="hypFinance" runat="server">
                                                </asp:HyperLink>    
			                                        <%--<a href="../rpt_finance.asp"><font class=blklnkund><strong>Finance</strong></font></a>--%>
                                                <strong> &gt; 
                                                                                Credit Control Report</strong><label id="lblBillRegister" class="bluefnt"><strong>&nbsp;</strong></label></td>
                                        </tr>
                                        
                                        <tr> 
                                            <td class="horzblue">
                                                
                                            </td>
                                        </tr>
                                        
                                        <tr> 
                                            <td>
                                               
                                            </td>
                                        </tr>
                                        
                                        <tr> 
                                            <td align="right">
                                                <a href="javascript:window.history.go(-1)" title="back">
                                                   
                                                </a>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 39%; valign="top">
                                                            
                                                            <%--Error messages are already handled in BillRegister.aspx.cs file--%>
                                                            
                                                            <%--Display error message table--%>
                                                            <%--<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblErrorMessage" runat="server">
                                                                <tr>
                                                                    <td style="height: 300" valign="top">
                                                                        <br />
                                                                        <br />
                                                                        <br />
                                                                        
						                                                <table border="1" cellspacing="0" cellpadding="2" width="70%" 
						                                                    align="center" class="bglightblue">
   					                                                        <tr>
   							                                                    <td align="center" class="bgbluegrey">
   							                                                        <label class="blackfnt" style="color: red">
   							                                                            <b>Result</b>
   							                                                        </label>
   							                                                    </td>
   							                                                </tr>
						                                                    
						                                                    <tr>
						                                                        <td>
						                                                            <br />
					                                                                <p align="center">
					                                                                    <label id="lblErrorMessage" runat="server" class="blackfnt">    
					                                                                    </label>
					                                                                    
					                                                                    <br />
					                                                                    <br />
					                                                                    
					                                                                    <label class="blackfnt">
					                                                                        <a href="javascript:history.go(-1)">
					                                                                            <u>
					                                                                                Back
					                                                                            </u>
					                                                                        </a>
					                                                                    </label>
					                                                                    
					                                                                    <br />
					                                                                </p>    
					                                                            </td>
					                                                        </tr>
					                                                    </table>
                                                                    </td>
                                                                </tr>
                                                            </table>--%>
                                                            
                                                            <%--Display bill details table--%>
                                                            <br />
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                    </b>
                                                                </label>
                                                            </p>
                                                            
                                                            <%--<center>--%>
                                                           
                                                            
                                                            <table border="0" cellpadding="3" width="565"  cellspacing="1" align="center" class="boxbg">
                                                                <tr bgcolor="#ffffff">
                                                                    <td class="blackfnt" style="height: 10px">
                                                                        Date :</td>
                                                                    <td style="height: 10px">
                                                                        <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                    <tr bgcolor="#ffffff">
                                                                        <td style="width: 205; height: 15px;">
                                                                            <label class="blackfnt">
                                                                                RO :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 15px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr bgcolor="#ffffff">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Location :</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr bgcolor="#ffffff">
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Customer Code :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                <tr bgcolor="#ffffff">
                                                                    <td style="height: 6px">
                                                                     <label class="blackfnt">
                                                                                Date Type : :</label>
                                                                        </td>
                                                                    <td bgcolor="#ffffff">
                                                                        <asp:Label ID="lbldt" runat="server" CssClass="blackfnt">
                                                                        Date Wise</asp:Label></td>
                                                                </tr>
                                                                <tr bgcolor="#ffffff">
                                                                  
                                                                     <td style="height: 6px">
                                                                  <label class="blackfnt">
                                                                                Flow Type : </label>
                                                                                </td>
                                                                    <td style="height: 6px">
                                                                       
                                                                        <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                                                                        Flow</asp:Label></td>
                                                                </tr>
                                                                </table>
                                                            
                                                               
                                                               
                                                               
                                                               
                                                            <%--</center>--%>
                                                            
<br />
                                                            <asp:GridView  align="center" ID="GridView1" runat="server" BorderWidth="0" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"  CellSpacing="1"
                              CssClass="boxbg"  Visible="false"     FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                             PagerSettings-NextPageText="[Next]" PagerSettings-PreviousPageText="[Previous]" 
                             
                             EmptyDataText="No Records Found..."  OnPageIndexChanging="pgChange" OnRowDataBound="GridView1_RowDataBound">
                                         <Columns >
                                 <asp:TemplateField  HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />  
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>   
                                 <%--<asp:BoundField   DataField="report_loc" HeaderText="Consignee" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                                
                                <asp:BoundField  DataField="loc_name" HeaderText="Location " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false"  BackColor="white"  />  
                                </asp:BoundField>
                               </Columns>
                               <Columns>
                                 <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=9"%>'  ID="Tot_buss"  runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Tot_ToBe_DKT") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                           <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                       
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="Tot_coll"   Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=9a"%>'        runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Coll_TObe_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                        
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton Font-Underline="true"  ID="Tot_OS" PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=9b"%>'  runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Coll_TObe_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                                 
                                      <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" />
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPay_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=10"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "Topay_TOBe_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="MR Not Made" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPay_mrnotmade"  Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=10a"%>'  runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Topay_MRNot_TOBe_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="MR Made" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPay_mrmade" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=10b"%>'  runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Topay_MR_TOBe_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPay_Coll" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=10c"%>'  runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Topay_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPay_OS"  Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=10d"%>'  runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Topay_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                           
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBB_Buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=11"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_TOBe_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBB_Coll"  runat="server"  Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=11a"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBB_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=11b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                   <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BOD_Buss"  runat="server"  Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=12"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "BOD_TOBe_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BOD_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=12a"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "BOD_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BOD_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=12b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "BOD_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="Nat_Buss1"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=13"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "NAtional_TOBe_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="National_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=13a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "NAtional_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="National_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=13b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "NAtional_TOBe_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCT_Buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBe_bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                           
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCT_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14a"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                           
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                      <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                      <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                             
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                              <%-- <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "Tot_ToBe_DKT") %>')">
                                           <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "Tot_ToBe_DKT") %>
                                        </a>
                                    </ItemTemplate>
                                                                 
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    <asp:TemplateField  HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "Coll_TObe_dkt") %>')">
                                           <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "Coll_TObe_dkt") %>
                                        </a>
                                    </ItemTemplate>
                                                                 
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField>
                                     <asp:TemplateField  HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "Tot_ToBe_DKT") %>')">
                                           <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "Tot_ToBe_DKT") %>
                                        </a>
                                    </ItemTemplate>
                                                                 
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField>--%></Columns>
                            
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           
           <FooterStyle CssClass="boxbg" />                   
                                                            </asp:GridView>
                                                            <asp:GridView Visible="false"   align="center" ID="GridView2" runat="server" BorderWidth="0" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"  CellSpacing="1"
                              CssClass="boxbg"      FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                             PagerSettings-NextPageText="[Next]" PagerSettings-PreviousPageText="[Previous]" 
                             
                             EmptyDataText="No Records Found..."  OnPageIndexChanging="pgChange"  OnRowDataBound="GridView2_RowDataBound">
                                         <Columns >
                                 <asp:TemplateField  HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />               
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>   
                                 <%--<asp:BoundField   DataField="report_loc" HeaderText="Consignee" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                                
                                <asp:BoundField  DataField="loc_name" HeaderText="Location " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                      <ItemStyle CssClass="blackfnt" Wrap="false" BackColor="white"  />
                                </asp:BoundField>
                               </Columns>
                               <Columns>
                                 <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TotG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=1"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Tot_DKT") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                     <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TotG_coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=1a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                      
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TotG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=1b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                     <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />   
                                     <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                     <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="PaidG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=2"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Paid_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                      
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                     <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="PaidG_coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=2a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "paid_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                           
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="PaidG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=2b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "paid_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                     <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />  
                                     <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                 
                                     <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPayG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=3"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Topay_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                      <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />              
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    <asp:TemplateField   HeaderText="MR Not Made" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPayG_mrnotmade"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=3a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Topay_MRNot_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                 <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                   
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    <asp:TemplateField   HeaderText="MR Made" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPayG_mrmade"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=3b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Topay_MR_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                               <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                    
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                                 
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPayG_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=3c"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Topay_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                      <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                 
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                             
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="ToPayG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=3d"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Topay_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                       
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    
                                 
                                     
                                     <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBBG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=4"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                        
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="Unbilled" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBBG_Unbilled"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=4a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_UnBill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
 <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />  
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    <asp:TemplateField   HeaderText="Billed" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBBG_Billed"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=4b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                            <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                    
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                            
                                    
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBBG_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=4c"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                                 
                                    
                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />               
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="TBBG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=4d"%>' Text='<%#DataBinder.Eval(Container.DataItem, "Tbb_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                             <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                       
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                     
                                      <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BODG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=5"%>' Text='<%#DataBinder.Eval(Container.DataItem, "BOD_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                   <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                 
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    <asp:TemplateField   HeaderText="Unbilled" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BODG_Unbilled"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=5a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "BOD_UnBill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                     <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                  
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                             
                                    <asp:TemplateField   HeaderText="Billed" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BODG_Billed"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=5b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "BOD_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                      <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                  
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                            
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BODG_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=5c"%>' Text='<%#DataBinder.Eval(Container.DataItem, "BOD_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                               <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                 
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="BODG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=5d"%>' Text='<%#DataBinder.Eval(Container.DataItem, "BOD_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                                 <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />               
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    
                                    
                                        
                                       <asp:TemplateField   HeaderText="Buss." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="NatG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=6"%>' Text='<%#DataBinder.Eval(Container.DataItem, "National_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                   <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                             
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="Unbilled" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="NatG_Unbilled"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=6a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "National_UnBill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    <asp:TemplateField   HeaderText="Billed" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="NatG_Billed"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=6b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "National_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                      <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                          
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="NatG_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=6c"%>' Text='<%#DataBinder.Eval(Container.DataItem, "National_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                       <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                            
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                 
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="NatG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=6d"%>' Text='<%#DataBinder.Eval(Container.DataItem, "National_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                            <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                           
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                             
                                    
                                    
                                    <asp:TemplateField   HeaderText="Billed." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCTG_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=7"%>' Text='<%#DataBinder.Eval(Container.DataItem, "OCT_Bill_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                            <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                            
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                            
                                    
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCTG_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=7b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "OCT_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                       
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                             
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCTG_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=7b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "OCT_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                    
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                                
                                    
                                    <asp:TemplateField   HeaderText="MR Made" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCTM_buss"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=8"%>' Text='<%#DataBinder.Eval(Container.DataItem, "OCT_MR_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                                                  <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />           
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                       
                                    
                                    <asp:TemplateField   HeaderText="Coll." HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton  ID="OCTM_Coll"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=8a"%>' Text='<%#DataBinder.Eval(Container.DataItem, "OCT_MR_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                          <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                      
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                    
                                    <asp:TemplateField   HeaderText="O/S" HeaderStyle-Width="15">
                                    <ItemTemplate  >
                                    <asp:LinkButton   ID="OCTM_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=8b"%>' Text='<%#DataBinder.Eval(Container.DataItem, "OCT_MR_Coll_dkt") %>'></asp:LinkButton>
                                    
                                    </ItemTemplate>
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white"  />                                         
                                    <HeaderStyle CssClass="blackfnt" /></asp:TemplateField> 
                                  
                                     </Columns>
                                    <RowStyle  />
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           
           <FooterStyle CssClass="boxbg" />                   
                                                            
                                                            </asp:GridView>
                                                           
                                                            
                                                        </td>
                                                    </tr>
                                                </table>
                                                
                                                <br />
                                                
                                                <table id="Table2"    runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td><asp:Button ID="btnShow" runat="server" Text="XLS Download"  OnClick="btnShow_Click" Width="75px"  /></td></tr>  
 
        </table>
                                              
                                                <%--<table border="0" align="center" cellpadding="0" cellspacing="4" 
                                                    id="tblPageNavigation" runat="server">
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                Page&nbsp;
                                                                <asp:Label id="CurrentPage" CssClass="blackfnt" runat="server" />
                                                                &nbsp;of&nbsp;
                                                                <asp:Label id="TotalPages" CssClass="blackfnt" runat="server" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    
                                                  <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="FirstPage" Text="[First Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="First" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="PreviousPage" Text="[Previous Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Prev" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="NextPage" Text="[Next Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Next" />    
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="LastPage" Text="[Last Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Last" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    
                                                    
                                                </table>
                                                
                                                <br />--%>
                                                
                                               
                                               
                                                <center>
                                                    
		                                        </center>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

    
    
    
    
    </asp:Content>

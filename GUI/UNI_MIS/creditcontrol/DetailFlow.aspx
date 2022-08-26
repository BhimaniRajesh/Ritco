<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="DetailFlow.aspx.cs" Inherits="Operation_DetailFlow" %>

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
                                            <td style="height: 19px">
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
                                                                                Docket Flow Detail Report</strong><label id="lblBillRegister" class="bluefnt"><strong>&nbsp;</strong></label></td>
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
                                                        <td style="width: 39%;  valign="top">
                                                            
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
                                                            <asp:GridView ID="GridView1" runat="server"
                                                                CellPadding="4" ForeColor="#333333" GridLines="None">
                                                               
                                                                
                                                                
                                                                                                         
                                                            </asp:GridView>
                                                            
                                                            <table border="0" cellpadding="3" width="565"  cellspacing="1" align="center" class="boxbg">
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 10px">
                                                                        Date :</td>
                                                                    <td style="height: 10px">
                                                                        <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                               Customer/ Location :</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr visible="false" style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Customer :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 6px">
                                                                        Status:</td>
                                                                    <td style="height: 6px">
                                                                        &nbsp;<asp:Label ID="lblstatus" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                </table>
                                                            
                                                               
                                                               
                                                               
                                                               
                                                            <%--</center>--%>
                                                            
                                                            <br />
                                                            
                                                            <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 9.5in%" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>Credit Control  Report&nbsp;</b></label></td>
                                                                </tr>
                                                            </table>
                                                                
                                                            <br />
                                                            
                                                            <center>
                                                                <table border="0" style="width: 9.5in%; " align="center" cellspacing="1" cellpadding="3" class="boxbg">
                                                                    <tr class="bgbluegrey">
                                                                        <td   height: 67px;">
                                                                            <label  class="blackfnt">
                                                                                Sr. No</label></td>
                                                                        
                                                                        <td >
                                                                            <label class="blackfnt">
                                                                                Docket number</label></td>
                                                                        
                                                                        <td >
                                                                            <label class="blackfnt">
                                                                                Dely. Location&nbsp;</label></td>
                                                                        
                                                                        <td >
                                                                            <label class="blackfnt">
                                                                                Consignor</label></td>
                                                                        
                                                                        <td >
                                                                            <label class="blackfnt">
                                                                                Consignee&nbsp;</label></td>
                                                                        
                                                                        <td >
                                                                            <label class="blackfnt">
                                                                                Bkg. Date</label></td>
                                                                        
                                                                      <%--  <td style="width: 300px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Comm. Dely. Date</label></td>--%>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Last Location&nbsp;</label></td>
                                                                        
                                                                       <%-- <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                &nbsp;Dep. Date</label></td>
                                                                                                                --%>                              
                                                                        
                                                                       <%-- <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Current Location</label></td>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Actual Location&nbsp;</label></td>--%>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Pkgs. No.</label></td>
                                                                        
                                                                        <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Charge Wt.</label></td>
                                                                                <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                               Docket Total</label></td>
                                                                               <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Arrival Date</label></td>
                                                                                 <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Delivery Date</label></td>
                                                                                 <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Bill No.</label></td>
                                                                                <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Bill Date</label></td>
                                                                                <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                MR No.</label></td>
                                                                                <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                MR Date</label></td>
                                                                                
                                                                                
                                                                        
                                                                                                                                        
                                                                    </tr>
                                                                    <asp:Repeater ID="rptBillDetails" runat="server">
                                                                        <ItemTemplate>
                                                                            <tr style="background-color: White">
                                                                                <td style="width: 198px">
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                                                                    </label>
                                                                                </td>
                                                                                <%--<td>
                                                                                    <label class="blackfnt">
                                                                                         
                                                                                            <asp:HyperLink  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# "./../MR_Details.aspx"%>' 
                                                                                                Runat="server" Target="_blank" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                                                                     ID="Hyperlink2" />
                                                                                        </a>
                                                                                    </label>
                                                                                </td>--%>
                                                                                
                                                                                
                                                                                
                                                                                 <td>
                                                                                    <label class="blackfnt">
                                                                                    <%#DataBinder.Eval(Container.DataItem, "dockno")%>
                                                                                        </a>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                    <%#DataBinder.Eval(Container.DataItem, "dly_loc")%>
                                                                                        </a>
                                                                                    </label>
                                                                                </td>
                                                                                <td nowrap>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "csgnnm")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td nowrap>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "csgenm")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td nowrap>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dockdt")%>
                                                                                    </label>
                                                                                </td>
                                                                                <%--<td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "cdeldt")%>
                                                                                    </label>
                                                                                </td>--%>
                                                                            <%-- <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "last_loc")%>
                                                                                    </label>
                                                                                </td>--%>
                                                                              <td>
                                                                                    <label class="blackfnt">
                                                                                         <%#DataBinder.Eval(Container.DataItem, "dept_dt")%>
                                                                                    </label>
                                                                                </td>
                                                                                  <%--<td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "curr_loc")%>
                                                                                    </label>
                                                                                </td>                                                                           
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dly_loc1")%>
                                                                                    </label>
                                                                                </td>--%>
                                                                                  <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "pkgsno")%>
                                                                                    </label>
                                                                                </td>
                                                                                  <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "chrgwt")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dkttot")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td nowrap>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "arrv_dt")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td nowrap>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dely_dt").ToString()%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "Billno")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td nowrap>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "bgndt")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "mrsno")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label s class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "mrsdt")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                            </tr>
                                                                            
                                                                        </ItemTemplate>
                                                                        
                                                                    </asp:Repeater>
                                                                  
                                                                    
                                                                </table>
                                                                
                                                                <%--Table for displaying no records found message--%>
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
                                                            </center>
                                                        </td>
                                                    </tr>
                                                </table>
                                                
                                                <br />
                                                <br />
                                                
                                               
                                              
                                                <table border="0" align="center" cellpadding="0" cellspacing="4" 
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
                                                
                                                <br />
                                                
                                               
                                            
                                                   <table id="Table2"   runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td><asp:Button ID="btnShow" runat="server" Text="XLS Download"  OnClick="btnShow_Click" Width="75px"  /></td></tr>  
 
        </table>
		                                        
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

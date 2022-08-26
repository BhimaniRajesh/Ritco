<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailFlow.aspx.cs" Inherits="Operation_DetailFlow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    
    
    <link id="Link2" href="~/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />

        
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
 
</head>
<body>
    <form id="form1" runat="server">
    
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
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
                                                        <td style="width: 39%; height: 762px;" valign="top">
                                                            
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
                                                            
                                                            <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 10px">
                                                                        Date :</td>
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
                                                            
                                                            <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 100%" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>Docket Flow Report&nbsp;</b></label></td>
                                                                </tr>
                                                            </table>
                                                                
                                                            <br />
                                                            
                                                            <center>
                                                                <table border="0" style="width: 98%; background-color: #808080" align="center" cellspacing="1" cellpadding="2" class="boxbg">
                                                                    <tr class="bgbluegrey">
                                                                        <td style="width: 10%; height: 67px;">
                                                                            <label class="blackfnt">
                                                                                Sr. No</label></td>
                                                                        
                                                                        <td style="width: 1736px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Docket number</label></td>
                                                                        
                                                                        <td style="width: 640px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Dely. Location&nbsp;</label></td>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Consignor</label></td>
                                                                        
                                                                        <td style="width: 46px; height: 67px;">
                                                                            <label class="blackfnt">
                                                                                Consignee&nbsp;</label></td>
                                                                        
                                                                        <td style="width: 41px; height: 67px;">
                                                                            <label class="blackfnt">
                                                                                Bkg. Date</label></td>
                                                                        
                                                                        <td style="width: 300px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Comm. Dely. Date</label></td>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Last Location&nbsp;</label></td>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                &nbsp;Dep. Date</label></td>
                                                                                                                                              
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Current Location</label></td>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Actual Location&nbsp;</label></td>
                                                                        
                                                                        <td style="height: 67px">
                                                                            <label class="blackfnt">
                                                                                Pkgs. No.</label></td>
                                                                        
                                                                        <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Charge Wt.</label></td>
                                                                                 <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Arrival Date</label></td>
                                                                                 <td style="width: 151px; height: 67px">
                                                                            <label class="blackfnt">
                                                                                Dely. Date</label></td>
                                                                        
                                                                                                                                        
                                                                    </tr>
                                                                    <asp:Repeater ID="rptBillDetails" runat="server">
                                                                        <ItemTemplate>
                                                                            <tr style="background-color: White">
                                                                                <td style="width: 198px">
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                         
                                                                                            <asp:HyperLink  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# "./../MR_Details.aspx"%>' 
                                                                                                Runat="server" Target="_blank" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                                                                     ID="Hyperlink2" />
                                                                                        </a>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                    <%#DataBinder.Eval(Container.DataItem, "dly_loc")%>
                                                                                        </a>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "csgnnm")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "csgenm")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dockdt")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "cdeldt")%>
                                                                                    </label>
                                                                                </td>
                                                                             <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "last_loc")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                         <%#DataBinder.Eval(Container.DataItem, "dep_dt")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "curr_loc")%>
                                                                                    </label>
                                                                                </td>                                                                           
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dly_loc1")%>
                                                                                    </label>
                                                                                </td>
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
                                                                                        <%#DataBinder.Eval(Container.DataItem, "arrv_dt")%>
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "dely_dt")%>
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
                                                
                                               
                                               
                                                <center>
                                                    <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Print  " runat="server" id="btnPrint" onclick="faction(1)" />
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  XLS  " runat="server" id="btnXML" onclick="faction(2)" />
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Email " runat="server" id="btnEmail" onclick="faction(3)" />
			                                                </td>
			                                            </tr>
		                                            </table>
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

    
    
    </form>
</body>
</html>

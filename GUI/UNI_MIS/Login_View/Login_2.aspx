<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Login_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

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
                                                 &gt; Vehicle<label class="blackfnt">    Report </label> </td>
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
                                                           
                                                           
                                                             <br />
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></b></label></p>
                                                            
                                                            <%--<center>--%>
                                                            
                                                            <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
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
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Employee :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblemp" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 6px">
                                                                     <label class="blackfnt">
                                                                         Login Instance &gt;=
                                                                     </label></td>
                                                                    <td style="height: 6px">
                                                                        <asp:Label ID="lblli" runat="server" CssClass="blackfnt">
                                                                        </asp:Label> </td>
                                                                </tr>
                                                                </table>
                                                            
                                                            
                                                            </td>
                                        </tr>
                                        
                                        <tr>
                                         <asp:GridView ID="GridView1" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  
                                                       
                                                            OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            
                                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle HorizontalAlign="center" />
                                                                </asp:GridView>
                                                                        <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                                                                            ForeColor="Red" Text="Label" Visible="False"></asp:Label>
         
            </tr>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
               
                
            </table>
            </td>
            </tr>
            
            <tr>
           
            </table>
            
             

    
    
    
    

</asp:Content>

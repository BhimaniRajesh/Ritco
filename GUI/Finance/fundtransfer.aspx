<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="fundtransfer.aspx.cs" Inherits="GUI_finance_fundtransfer" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fund Transfer</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    

						<table border=0 cellpadding="5" width="35%" cellspacing="1" align="left" class=boxbg>
                            <TR class=bgbluegrey>
                              
                              <TD colspan=1 align=middle style="height: 1px; width: 335px;" >
                                <FONT class=blackfnt><strong>Transactions</strong></FONT>
                              </TD>
                            </tr>  
                            <tr bgcolor="#FFFFFF">
                                                     <td nowrap style="width: 335px" ><font class=blackfnt>
                                                         <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/GUI/finance/advice/advice.aspx">Advice Entry</asp:HyperLink><a href="#"></a></font><font class=blackfnt>&nbsp;</font></td>   
                            </tr>	
							<tr bgcolor="#FFFFFF">
                            
                             <td style="width: 335px"><font class=blackfnt>
                                 <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/GUI/finance/advice/AdvRecv_step1.aspx">Advice Acknowledgement</asp:HyperLink><a href="#"> </a></font></td>
                            </tr>	    
							
							
							
                       
							 <TR bgcolor="#FFFFFF">
                              <TD colspan=2 align=middle style="height: 28px">
                                <FONT class=blackfnt><strong>View & Print</strong></FONT>
                              </TD>
                            </tr> 
                            <tr bgcolor="#FFFFFF">
                            
                               
                            <td style="width: 335px"><font class=blackfnt><a href="#"><u> Advices </u></a></font></td>
                                                        </TABLE>
</asp:Content>


<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="MR_Details.aspx.cs" Inherits="MR_Details" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
  
                                                               
                                                               
                                                               
                                                               
                                                                   
<table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 100%" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                MR Summary
                                                                            </b>    
                                                                        </label>
                                                                    </td>
                                                                </tr>                                                              
                                                                <tr style="background-color: White">
                                                                        <td style="width: 198px">
                                                                     MR No.</td>
					                                                              <td><%=STRMRSNO%></td>
					                                                              <td style="width: 20%">
                                                                     MR Date.</td>
					                                                              <td><%=STRMRDT1%></td>
					                                                              
					                                                    </tr>   
					                                                     <tr style="background-color: White">
                                                                        <td style="width: 20%">
                                                                     MR Type.</td>
					                                                              <td><%=STRMRSTYPE%></td>
					                                                              <td style="width: 20%">
                                                                     MR Branch.</td>
					                                                              <td><%=STRMRSBR%></td>
					                                                              
					                                                    </tr>
					                                                     <tr style="background-color: White">
                                                                        <td style="width: 198px">
                                                                     CNote No.</td>
					                                                              <td><%=STRDOCKNO%></td>
					                                                              <td style="width: 20%">
                                                                     Date</td>
					                                                              <td><%=STRDOCDT1%></td>
					                                                              
					                                                    </tr>    
					                                                    <tr style="background-color: White">
					                                                    <td>
					                                                    Party
					                                                    </td>
					                                                    <td>
					                                                    <%=STRPTNAME%>
					                                                    </td>
					                                                  
					                                                    </tr>
					                                                    
					                                                         </table>
							
						
            
</asp:Content>

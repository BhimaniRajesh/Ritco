<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="document_cancel_list.aspx.cs" Inherits="GUI_Operations_document_cancel_document_cancel_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

function OpenPopupWindowManifest(strDocketNo,documenttype)
{
if(documenttype == "Docket")
    {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../Operation/SingleScreen_docketEntry/DocketPrint/docketview_xls.aspx?dockno=" + strDocketNo +",."
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }

if(documenttype == "Manifiest")
    {
    //var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    //var strPopupURL = "#"
    //winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }

if(documenttype == "THC")
    {
    //var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    //var strPopupURL = "#"
    //winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
}



</script>
<br />
<div align="center">
<%--<table id="ErrTable" runat="server" border="1" cellspacing="0" cellpadding="2" width="85%" align="center" class="bglightblue">
   					       <tr><td align="center" class="bgbluegrey"><font class="blackfnt" color="red"><b>ERROR !!!</b></font>
   					       
   					       </td></tr>
						  <tr><td><br />
						   <p align="center"><font class="blackfnt" color="red"></font>
						   <br /><font class="blackfnt"><a href="javascript:window.history.go(-1)"><u>Click here for return to previous screen</u></a></p>
						   </td>
						  </tr>
						 </table>--%>
						 
<table id="table1" runat="server" border="0" cellpadding="3" cols="1"  width="75%" cellspacing="1" class="boxbg" align="center">
							<tr class="bgbluegrey">
							    <td style="height: 25px" ><font class="blackfnt">Document Type</font></td>
								<td style="height: 25px" ><font class="blackfnt">Document No.</font></td>
								<td style="height: 25px" ><font class="blackfnt">Document Location</font></td>
								
							</tr>
							<tr bgcolor="white">
							    <td><font class="blackfnt">
                                    <asp:Label ID="lblDocType" runat="server" ></asp:Label></font></td>
								<td><font class="blackfnt">
								<%--<a href="JavaScript:OpenPopupWindowManifest('<%=docno%>','<%=documenttype %>')">--%>
                                          <%=docno%>
                                       <%-- </a>--%>
								</td>
								
								<td><font class="blackfnt">
                                    <asp:Label ID="lblLocation" runat="server"></asp:Label></font></td>
								
							</tr>
							</table>
							<br />
							<asp:Button ID="btnSubmit" runat="server"  Text="Cancel Document" OnClick="btnSubmit_Click"/>

</div>

</asp:Content>

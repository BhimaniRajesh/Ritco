<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="frmNewRequest_result.aspx.cs" Inherits="Request_frmNewRequest_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">



<script language="javascript">
 
 function ViewPrint(tReqId,tPrintMode)
 {
    
	var strurl="frmRequestPrint.aspx?Id=" + tReqId + "&PrintMode=" + tPrintMode  
     popup = window.open(strurl,"","height=475,width=850,scrollbars=yes,left=100,top=125");
 }
 

</script>


<%
   string ReqId ="";
   ReqId = Request.QueryString["ReqId"];
   lblDocNoVal.Text = ReqId;
 %>


<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Request >> New Request</asp:Label>
                >>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">New Request Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br>
    <center>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="70%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document is generated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> &nbsp;</td>
            
            
        </tr>

        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="Vehicle Request" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                
                <%--<asp:LinkButton ID="lnkView" runat="server" Text="View"  CausesValidation="true" CssClass="blackfnt" OnClientClick="javascript:ViewPrint('0')"></asp:LinkButton>--%>
                <a href="javascript:ViewPrint('<%=ReqId%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <%--<asp:LinkButton ID="LinkPrint" runat="server" Text="Print" CausesValidation="true" OnClientClick="javascript:ViewPrint('1')"  CssClass="blackfnt"></asp:LinkButton>--%>
                 <a href="javascript:ViewPrint('<%=ReqId%>','1')"><font class="blackfnt">Print</font></a>

                <asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt" ></asp:LinkButton>
            </td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Enter More Vehicle Requests" CssClass="blackfnt" PostBackUrl="frmNewRequest.aspx"/>
            </td>
        </tr>
       <%-- <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="Fulfill a Requests" CssClass="blackfnt" PostBackUrl="#"/>
            </td>
        </tr>--%>
        
         <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Requests" CssClass="blackfnt" PostBackUrl="frmViewPrintRequestQuery.aspx"/>
            </td>
        </tr>
       
        
    </table>
    </center>
</asp:Content>    

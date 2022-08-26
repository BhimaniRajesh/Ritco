<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmAddNewJourneyDone.aspx.cs" Inherits="Issue_frmAddNewJourneyDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">



<script language="javascript">
 
 function ViewPrint(tTripSheetNo,tPrintMode)
 {
    
	var strurl="frmViewPrintVehicleIssueSlip.aspx?VSlipNO=" + tTripSheetNo + "&PrintMode=" + tPrintMode  
     popup = window.open(strurl,"","height=475,width=850,scrollbars=yes,left=100,top=125");
 }
 

</script>


<%
   string TripSheetNo = "";
   TripSheetNo = Request.QueryString["TripSheetNo"];
   lblDocNoVal.Text = TripSheetNo;

   string mAddEdit = Session["AddEdit"].ToString();
    
    
 %>

<%if (mAddEdit=="I"){ %>
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Add Journey </asp:Label>
                >>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">New Journey Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
</table>
<%}
else {%>
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Add Journey  </asp:Label>
                >>
                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Journey Updated</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
</table>

<%} %>
<br>
    <center>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="70%">
        <%if (mAddEdit=="I"){ %>
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document is generated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <%}else {%>
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="Label4" runat="server"  Font-Bold="true" Text="Following document is updated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <%} %>
        
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
                <asp:Label ID="lblDocNameVal" runat="server" Text="Trip Sheet" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                
                
                <a href="javascript:ViewPrint('<%=TripSheetNo%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                 <a href="javascript:ViewPrint('<%=TripSheetNo%>','1')"><font class="blackfnt">Print</font></a>

                <asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt" ></asp:LinkButton>
            </td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
 <%--<%if (mAddEdit == "I")
           { %>
        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Prepare More Trip Sheet" CssClass="blackfnt" PostBackUrl="frmTripSheet.aspx"/>
            </td>
        </tr>
        <%}else { %>
        
            <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="Close More Trip Sheet" CssClass="blackfnt" PostBackUrl="frmTripSheetCloseQuery.aspx"/>
            </td>
        </tr>
         <%} %>--%>
         
          <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="Add More Journey" CssClass="blackfnt" PostBackUrl="frmAddNewJourneyQuery.aspx"/>
            </td>
        </tr>

         <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Trip Sheet" CssClass="blackfnt" PostBackUrl="frmViewPrintVehicleIssueSlipQuery.aspx"/>
            </td>
        </tr>
     
      
        
    </table>
    </center>
</asp:Content>    
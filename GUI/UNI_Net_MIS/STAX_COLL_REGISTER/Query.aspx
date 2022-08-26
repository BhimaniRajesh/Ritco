<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_STAX_COLL_REGISTER_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    
	    function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "./../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }

    
        function OnSub_DATACHECK()
         {
        
            if(!DateCheck())
                return false;
          //  alert("HIii")
            /*if(!FinDateCheck())
                return false;       */      
         }
    </script>

  
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 22/5/2014 --%>
  <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Service Collected Register </strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table id="tblCriteria" runat="server" align="Left" border="0" cellpadding="0" cellspacing="1"
                        class="boxbg" width="700">
                        <tr class="bgbluegrey">
                            <td colspan="2" style="text-align: center; height: 25px;">
                                <strong>Search Criteria</strong></td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Booking Location</font>
                            </td>
                            <td align="left">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td class="blackfnt" style="height: 25px; text-align: left;">
                                &nbsp;Select
                                <asp:DropDownList ID="DTTYP" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Text="MR Date" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Docket Date" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Bill Date" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                                </td>
                            <td style="height: 78px">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="TR_BM2" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="Left" >
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="260"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="TR_BM5" runat="server" style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>
                        <tr id="TR_BM6" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">BILL No.</font>
                            </td>
                            <td align="left" >
                                <asp:TextBox runat="server" Text="" ID="txtbillno" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="TR_BM9" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">MR No.</font>
                            </td>
                            <td align="left" >
                                <asp:TextBox runat="server" Text="" ID="txtMRNOLIST" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                         <tr id="TR_BM7" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Docket No.</font>
                            </td>
                            <td align="left" >
                                <asp:TextBox runat="server" Text="" ID="txtDktno" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                       <tr align="center" bgcolor="white">
                        <td colspan="2">
                            <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                runat="server" Text="Show" Width="75px" />
                        </td>
                    </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>

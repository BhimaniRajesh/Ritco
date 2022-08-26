<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" 
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_TDS_REgister_Query"   %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function SelectPartyCode()
     {
    
       // var ddl = document.getElementById('ctl00_MyCPH1_documet_type');
       // alert("hii..")
        if(document.getElementById("ctl00_MyCPH1_documet_type_0").checked ==true)
        {
         //alert("hii..1")
            document.getElementById('ctl00_MyCPH1_TR_REC1').style.display = "block";
            document.getElementById('ctl00_MyCPH1_TR_REC2').style.display = "block";
            document.getElementById('ctl00_MyCPH1_TR_Pay1').style.display = "none";
            document.getElementById('ctl00_MyCPH1_TR_Pay2').style.display = "none";  
            // alert("hii..12")         
        }
        else if(document.getElementById("ctl00_MyCPH1_documet_type_1").checked ==true)
        {
        //alert("hii..2")
            document.getElementById('ctl00_MyCPH1_TR_REC1').style.display = "none";           
            document.getElementById('ctl00_MyCPH1_TR_REC2').style.display = "none";            
            document.getElementById('ctl00_MyCPH1_TR_Pay1').style.display = "block";
            document.getElementById('ctl00_MyCPH1_TR_Pay2').style.display = "block";
       // alert("hii..21")
            
        }
        
        
              
        //return false;
     }
     
     
     function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;             
     }
     
     function validFloat(event,txtid)
        {
        var tb=document.getElementById(txtid);
        var txt=tb.value;
        if(event.keyCode==13)
        return true;

        if(event.keyCode==46)
        if(txt.indexOf('.')!=-1)
        event.keyCode=0;

        if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
        }
    </script>

    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>TDS Register Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true">
                                    </asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Voucher Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Voucher Date</font>
                                <%--<asp:dropdownlist id="DT_TYPE" runat="server">
         <asp:ListItem Text="Generation Date" Value="1" ></asp:ListItem>
         <asp:ListItem Text="Collection Date" Value="2" ></asp:ListItem>
         <asp:ListItem Text="Cancellation Date" Value="3" ></asp:ListItem>

                                </asp:dropdownlist>--%>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server" style="background-color: white">
                            <td align="left" colspan="1">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select TDS Type" runat="server"></asp:Label></td>
                            <td align="left" colspan="3" valign="top">
                                <%-- <asp:UpdatePanel ID="updatepanel3" runat="server">
                                    <ContentTemplate>--%>
                                <asp:RadioButtonList ID="documet_type" runat="server" RepeatDirection="horizontal"
                                    CssClass="blackfnt" OnClick="Javascript:return SelectPartyCode()">
                                    <asp:ListItem Text="Receivable" Selected="true" Value="R"></asp:ListItem>
                                    <asp:ListItem Text="Payable" Value="P"></asp:ListItem>
                                </asp:RadioButtonList><%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                        <tr  id="TR_REC1" runat="server" bgcolor="white" style="display: block;" >
                            <td align="left">
                                <font class="blackfnt">Select TDS Ledger</font>
                            </td>
                            <td align="left" style="width: auto;" colspan="3">
                                <asp:dropdownlist id="DLL_TDS_REC" runat="server"></asp:dropdownlist>
                               
                            </td>
                        </tr>
                        <tr id="TR_Pay1" runat="server"  bgcolor="white" style="display: none;">
                            <td align="left">
                                <font class="blackfnt">Select TDS Ledger</font>
                            </td>
                            <td align="left" style="width: auto;" colspan="3">
                                <asp:dropdownlist id="DLL_TDS_Pay" runat="server"></asp:dropdownlist>
                               
                            </td>
                        </tr>
                        <tr  id="TR_REC2" runat="server" bgcolor="white" style="display: block;">
                            <td align="left">
                                <font class="blackfnt">Select Customer</font>
                            </td>
                            <td align="left" style="width: auto;" colspan="3">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                 <br />
                                <font class="blackboldfnt">OR</font>
                                 <br />
                                 <asp:TextBox runat="server" Enabled="false" CssClass="blackboldfnt" Text="8888" ID="txtCustcd" Width="60"> </asp:TextBox><font class="blackboldfnt"> : </font> <asp:TextBox  CssClass="blackfnt" runat="server" Text="" ID="txtCustnm" Width="170"> </asp:TextBox>
                           
                            </td>              
               
            </tr>
            <tr id="TR_Pay2"  runat="server" bgcolor="white" style="display: none;">
                            <td align="left">
                                <font class="blackfnt">Select Vendor</font>
                            </td>
                            <td align="left" style="width: auto;" colspan="3">
                                <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                <br />
                                <font class="blackboldfnt">OR</font>
                                 <br />
                                 <asp:TextBox runat="server" Enabled="false" CssClass="blackboldfnt" Text="8888" ID="txtVendcd" Width="60"> </asp:TextBox><font class="blackboldfnt"> : </font> <asp:TextBox  CssClass="blackfnt" runat="server" Text="" ID="txtVendnm" Width="170"> </asp:TextBox>
                            </td>
               
            </tr>
           <%-- <tr style="background-color: white">
                <td align="center" colspan="4">
                    <font class="blackboldfnt">OR</font>
                </td>
                 </tr>--%>
            <tr style="background-color: white">
                <td align="left">
                    <font class="blackfnt">Voucher No.</font>
                </td>
                <td align="left" style="width: auto;" colspan="3">
                    <asp:TextBox runat="server" Text="" ID="txtVRno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left">
                    <font class="blackfnt">Search by Amount</font>
                </td>
                <td align="left" style="width: auto;" colspan="3">
                    <asp:TextBox runat="server" text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))" ID="amtfrm" Width="100"> </asp:TextBox>
                    <font class="blackfnt">To</font>
                    <asp:TextBox runat="server" text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))" ID="amtto" Width="100"> </asp:TextBox>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="4">
                    <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" OnClientClick="Javascript:return OnSub_DATACHECK();" />
                    <%--OnClientClick="Javascript: return OnSub_DATACHECK();"--%>
                </td>
            </tr>
        </table>
        </td> </tr> </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCGenerationCriteria.aspx.cs" Inherits="GUI_Operations_THCGeneration_THCGenerationCriteria" %>

<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>
    <script type="text/javascript" language="JavaScript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	function cust(ID) {
	    ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
	    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
	    var strPopupURL = "../../UNI_NET_MIS/PopUp_Cust.aspx?ID=" + ID

	    winNew = window.open(strPopupURL, "_blank", strWinFeature)
	}
	</script>
    <asp:Panel HorizontalAlign="Left" runat="server">
        <asp:UpdatePanel ID="upTHCCreate" UpdateMode="Conditional" RenderMode="Inline" runat="server">
            <ContentTemplate>
                <asp:Table runat="server" CssClass="stbl" CellSpacing="1" Width="600">
                    <asp:TableRow CssClass="hrow">
                        <asp:TableHeaderCell ColumnSpan="6" HorizontalAlign="Center">Select Criteria for THC</asp:TableHeaderCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell>
                            <asp:Label runat="server" ID="Label1" CssClass="nfnt" Text="Select Location Type"></asp:Label></asp:TableCell>
                        <asp:TableCell HorizontalAlign="Left">
                            <asp:RadioButtonList runat="server" AutoPostBack="true" ID="rdltype" OnSelectedIndexChanged="OnLocationTYpeChange"
                                RepeatDirection="Horizontal" CssClass="nfnt">
                                <asp:ListItem Text="From Booking Location" Value="1"></asp:ListItem>
                                <asp:ListItem Text="From Godown" Value="2"></asp:ListItem>
                                <asp:ListItem Text="All" Selected Value="3"></asp:ListItem>
                            </asp:RadioButtonList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell Wrap="false">
                            <asp:UpdatePanel ID="updDateType" runat="server">
                                <ContentTemplate>
                                    <asp:Label runat="server" ID="lblDateType" CssClass="nfnt" Text="Select "></asp:Label>
                                    <asp:DropDownList runat="server" ID="dllDateType" CssClass="ddl">
                                        <asp:ListItem Text="Booking Date" Value="dockdt"></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="rdltype" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </asp:TableCell>
                        <asp:TableCell>
                            <Date:DT ID="DT" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell>
                            <asp:Label runat="server" ID="lblPaymentBasis" CssClass="nfnt" Text="Select Payment Basis"></asp:Label></asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList runat="server" DataTextField="codedesc" DataValueField="codeid"
                                ID="ddlPaymentBasis" CssClass="ddl">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell>
                            <asp:Label runat="server" ID="lblModeBasis" CssClass="nfnt" Text="Select Transport Mode"></asp:Label></asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList runat="server" DataTextField="codedesc" DataValueField="codeid"
                                ID="dllModeBasis" CssClass="ddl">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell>
                            <asp:Label runat="server" ID="lblServiceClass" CssClass="nfnt" Text="Select Booking Type"></asp:Label></asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList runat="server" DataTextField="codedesc" DataValueField="codeid"
                                ID="dlllServiceClass" CssClass="ddl">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell>
                            <asp:Label runat="server" ID="lblBusinessTYpe" CssClass="nfnt" Text="Select Business Type"></asp:Label></asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList runat="server" DataTextField="codedesc" DataValueField="codeid"
                                ID="dllBusinessTYpe" CssClass="ddl">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                     <asp:TableRow CssClass="nrow">
                        <asp:TableCell>
                            <asp:Label runat="server" ID="Label2" CssClass="nfnt" Text="Enter Destination"></asp:Label></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtstartBranch" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                                type="button" onclick="cust('L');" value="..." style="width: 18px; height: 21px"
                                                size="" />
                                            <font class="blackfnt">[separated by <i>comma</i> if multiple]</font>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="6">
                            <asp:Button ID="btnSubmit" OnClick="btnSubmitClick" Text="Submit" runat="server"
                                CssClass="nbtn" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
      <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>
</asp:Content>

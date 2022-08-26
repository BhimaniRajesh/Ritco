<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReAllocateUnusedSeries.aspx.cs" Inherits="GUI_ReAllocateUnusedSeries"  EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>

<script language="javascript" type="text/javascript">
    function EnableDocSrFromTo()
    {        
            document.aspnetForm.ctl00_MyCPH1_txtDocSrFrom.disabled = false;
            document.aspnetForm.ctl00_MyCPH1_txtDocSrTo.disabled = false;
            document.aspnetForm.ctl00_MyCPH1_txtDecSrContains.disabled = true;
            document.aspnetForm.ctl00_MyCPH1_txtDecSrContains.value='';            
            document.aspnetForm.ctl00_MyCPH1_txtDocSrFrom.focus();
    } 
    function EnableDocSrContains()
    {
            document.aspnetForm.ctl00_MyCPH1_txtDocSrFrom.disabled = true;
            document.aspnetForm.ctl00_MyCPH1_txtDocSrTo.disabled = true;
            document.aspnetForm.ctl00_MyCPH1_txtDecSrContains.disabled = false;
            document.aspnetForm.ctl00_MyCPH1_txtDocSrFrom.value='';
            document.aspnetForm.ctl00_MyCPH1_txtDocSrTo.value = '';
            document.aspnetForm.ctl00_MyCPH1_txtDecSrContains.focus();
    }
</script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white" width="75%">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Reallocate Unused DCR Series</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>            
        </tr>
    </table>
    <br />

    <script src="../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../Js/AssignValue.js" language="javascript" type="text/javascript"></script>
        
    <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
        runat="server" visible="true">
        <tr class="bgbluegrey">
            <td colspan="2" style="text-align: left">
                <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select DCR Criteria"
                    Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" rowspan="4" valign="Top">
                <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="Docket Date :">
                </asp:Label>
            </td>
            <td align="left">
                <input type="radio" id="radFromToDate" runat="server" enableviewstate="true" checked onclick="javascript:document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=false;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=false;document.aspnetForm.ctl00_MyCPH1_txtFrom.focus();" />
                <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70" EnableViewState="true"></asp:TextBox>
                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFrom,'a1','dd/MM/yyyy'); return false;"
                    id="a1">
                    <img src="./../images/calendar.jpg" border="0" />
                </a>
                <asp:RegularExpressionValidator ValidationGroup="grpQuery" SetFocusOnError="true"
                    ID="REVDtFrom" runat="server" ErrorMessage="!" ToolTip="Invalid Date/Date Format"
                    ControlToValidate="txtFrom" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                &nbsp;
                <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                &nbsp;
                <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70" EnableViewState="true"></asp:TextBox>
                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTo,'a2','dd/MM/yyyy'); return false;"
                    id="a2">
                    <img src="./../images/calendar.jpg" border="0" />
                </a>
                <asp:RegularExpressionValidator ValidationGroup="grpQuery" SetFocusOnError="true"
                    ID="REVDtTo" runat="server" ErrorMessage="!" ToolTip="Invalid Date/Date Format"
                    ControlToValidate="txtTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                <asp:Label ID="lblddmmyyyy" runat="server" CssClass="bluefnt" Text=" [dd/mm/yyyy] " />
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <input type="hidden" id="hdtToday" runat="server" />
                <input type="hidden" id="hdt2" runat="server" />
                <input type="hidden" id="hdt1" runat="server" />
                <input type="hidden" id="hdt" runat="server" />
                <input type="radio" id="radToday" runat="server" onclick="Javascript:AssignValue(document.aspnetForm.ctl00_MyCPH1_txtFrom,document.aspnetForm.ctl00_MyCPH1_hdtToday);AssignValue(document.aspnetForm.ctl00_MyCPH1_txtTo,document.aspnetForm.ctl00_MyCPH1_hdtToday);document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=true;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=true;" />
                <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - </asp:Label>
                <asp:Label ID="lblTodayVal" runat="server" CssClass="bluefnt"><%=dtToday%></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <input type="radio" id="radLastWeek" runat="server" onclick="Javascript:AssignValue(document.aspnetForm.ctl00_MyCPH1_txtFrom,document.aspnetForm.ctl00_MyCPH1_hdt2);AssignValue(document.aspnetForm.ctl00_MyCPH1_txtTo,document.aspnetForm.ctl00_MyCPH1_hdt1);document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=true;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=true;" />
                <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - </asp:Label>
                <asp:Label ID="lblLastWeekVal" runat="server" CssClass="bluefnt"><%=dtLastWeek%></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <input type="radio" id="radTillDate" runat="server" onclick="Javascript:AssignValue(document.aspnetForm.ctl00_MyCPH1_txtFrom,document.aspnetForm.ctl00_MyCPH1_hdt);AssignValue(document.aspnetForm.ctl00_MyCPH1_txtTo,document.aspnetForm.ctl00_MyCPH1_hdt1);document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=true;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=true;" />
                <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
            </td>
        </tr>
       
        <tr bgcolor="white">
           <td align="left" rowspan="2" valign="Top">
                <asp:Label ID="lblDocFrom" runat="server" CssClass="blackfnt" Text="Docket Series :">
                </asp:Label>                
            </td>
            <td align="left">
               <input type="radio" id="radDocSrFrom" name="DocSr" runat="server" checked onclick="Javascript:EnableDocSrFromTo();" />
               <asp:Label ID="lblDocSrFrom" runat="server" CssClass="blackfnt" Text="From : " />               
               <input type="text" id="txtDocSrFrom" runat="server" />
               &nbsp;
               <asp:Label ID="lblDocSrTo" runat="server" CssClass="blackfnt" Text="To : " />               
               <input type="text" id="txtDocSrTo" runat="server" />
            </td>
        </tr>        
        <tr bgcolor="white">
            <td align="left">
               <input type="radio" id="radDecSrContains" name="DocSr" runat="server" 
               onclick="Javascript:EnableDocSrContains();" />
                <asp:Label ID="lblDecSrContains" runat="server" CssClass="blackfnt" Text="Contains No. : " />             
               <input type="text" id="txtDecSrContains" runat="server" disabled="true" />
               <asp:Label ID="Label1" runat="server" CssClass="blackfnt">[seperated by <i>
                    comma</i> if multiple]</asp:Label>
               </td>
        </tr>
        <tr bgcolor="white">
           <td align="left" valign="Top">
                <asp:Label ID="lblBookCode" runat="server" CssClass="blackfnt" Text="Book Code :">
                </asp:Label>
            </td>
            <td align="left">                              
               <asp:TextBox ID="txtBookCode" runat="server"></asp:TextBox>
               <asp:Label ID="Label6" runat="server" CssClass="blackfnt">[seperated by <i>
                    comma</i> if multiple]</asp:Label>
            </td>
        </tr>
        <tr bgcolor="white" runat="server">
            <td align="left" valign="Top">
                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Business Type :"></asp:Label>
            </td>
            <td align="left"><asp:DropDownList ID="ddlBusinessType" runat="server" ></asp:DropDownList></td>
        </tr>
    </table>
    </ContentTemplate>
</asp:UpdatePanel>
    <br />
  <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="trSubmit"
        visible="false" class="boxbg">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Show DCR Series >>" OnClick="ShowDCRs"/>
                &nbsp;
                <input type="reset" title="Reset"/>
            </td>            
        </tr>
    </table>    
    <br />
    <table border="0" cellspacing="1" cellpadding="3" width="900px">
        <tr>
            <td align="center">
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>            
        </tr>
    </table>
    <table border="0" cellspacing="1" cellpadding="3" runat="server" id="tblDCR" width="900px" class="blackfnt">
        <tr style="background-color: white">
            <td align="center" width="100%">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server" >
                    <ContentTemplate>
                        <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False" DataKeyNames="Doc_Key" 
                            CssClass="dgRowStyle" CellSpacing="1" CellPadding="3" AllowPaging="True" PageSize="20" Width="100%" 
                            PagerSettings-Mode="NumericFirstLast" DataSourceID="SqlDataSource1">
                            <Columns>
                                <asp:CommandField EditText="Re-Allot" ShowEditButton="True"  />
                                <asp:BoundField DataField="BookCode" HeaderText="Book Code" InsertVisible="False"
                                    ReadOnly="True" SortExpression="BookCode" />
                                <asp:BoundField DataField="DOC_SR_FROM" HeaderText="Series From" ReadOnly="True"
                                    SortExpression="DOC_SR_FROM" />
                                <asp:BoundField DataField="DOC_SR_To" HeaderText="Series To" ReadOnly="True" SortExpression="DOC_SR_To" />
                                <asp:BoundField DataField="Alloted_On" HeaderText="Alloted On" ReadOnly="True" SortExpression="Alloted_On" />
                                <asp:BoundField DataField="Alloted_By" HeaderText="Alloted Branch" ReadOnly="True" />
                                <asp:BoundField DataField="Alloted_To" HeaderText="Alloted To" />
                                <asp:BoundField DataField="Alloted_To_Name" HeaderText="Alloted To Name" ReadOnly="True" />                                
                                <asp:BoundField DataField="BUSINESS_TYPE" HeaderText="Business Type" ReadOnly="True" />
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" Wrap="false" />
                            <RowStyle CssClass="dgRowStyle" HorizontalAlign="center" Wrap="false"/>                            
                            <PagerStyle CssClass="pager" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr align="center" class="bgbluegrey">
            <td>
                <asp:Button ID="btnExport" runat="server" Text="Export XLS" OnClick="btnExport_Click" /> 
            </td>
        </tr> 
    </table>
   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"        
        OldValuesParameterFormatString="Original_{0}" ProviderName="System.Data.SqlClient"
        UpdateCommand="Exec usp_Series_ReAlloteUnused @Original_Doc_Key, @Alloted_To, @empcd">        
        <UpdateParameters>
            <asp:Parameter Name="Original_Doc_Key" Type="Int32" />
            <asp:Parameter Name="Alloted_To" Type="String" />
            <asp:Parameter Name="Original_Alloted_To" Type="String" />
            <asp:SessionParameter Name="empcd" Type="String" SessionField="empcd"/>
        </UpdateParameters>
    </asp:SqlDataSource>
     
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>

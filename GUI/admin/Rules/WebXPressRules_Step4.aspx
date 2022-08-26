<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="WebXPressRules_Step4.aspx.cs" Inherits="GUI_admin_WebXPressRules_Step4" Title="WebXPress Rules - Step 4" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
            
    <script language="javascript">
                
        function disableenter()
        {
        
        }    
        
        function ValidateDocumentPrefix()
        {
            
            
            
            return true;       
        }
                
        function ValidateData()
        {
            //Check Document Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlDocument"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlDocument").value == "-1")
                {
                    alert("Please select Document from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlDocument").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for Document!");
                return false;
            }
            
            //Check Document Prefix Size Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlDocPrefixSize"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlDocPrefixSize").value == "-1")
                {
                    alert("Please select Document Prefix Size from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlDocPrefixSize").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for Document Prefix Size!");
                return false;
            }
            
            //Check Document Prefix Value
            if (document.getElementById("ctl00_MyCPH1_txtDocPrefix"))
            {
                if (document.getElementById("ctl00_MyCPH1_txtDocPrefix").value == "")
                {
                    alert("Please enter Document Prefix!");
                    document.getElementById("ctl00_MyCPH1_txtDocPrefix").focus();
                    return false;
                }
            }
            else
            {
                alert("Input box not available for Document Prefix!");
                return false;
            }    
            
            //Check Year Code Required Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlYearCode"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlYearCode").value == "-1")
                {
                    alert("Please select Year Code Required from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlYearCode").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for Year Code Required!");
                return false;
            }
            
            //Check Running No. Length Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlRunNoLen"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlRunNoLen").value == "-1")
                {
                    alert("Please select Running No. Length from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlRunNoLen").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for Running No. Length!");
                return false;
            }
            
            //Check Separator Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlSeparator"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlSeparator").value == "-1")
                {
                    alert("Please select Separator from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlSeparator").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for Separator!");
                return false;
            }
            
            //Check Nomenclature Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlNomenclature"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlNomenclature").value == "-1")
                {
                    alert("Please select Nomenclature from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlNomenclature").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for Nomenclature!");
                return false;
            }
            
            return true;
        }
            
    </script>
        
    <div>
            
        <input type="hidden" id="HidDocket" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
            
        <table cellpadding="1" cellspacing="1" border="0" width="100%">
            
            <tr>
	            <td colspan="1" align="left">
		            <label class="blackfnt">
		                <b>
		                    WebXPress Rules - Step 4
		                </b>
		            </label>
		            <hr align="center" size="1" color="#8ba0e5">
	            </td>
            </tr>
            
            <tr>
                <%--<td style="width: 5%">
                    &nbsp;
                </td>--%>
                
                <td style="width: 90%">
                    <table cellpadding="1" cellspacing="1" class="boxbg" width="100%" border="0">
                        <%--Row for header--%>
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 20px;" nowrap>
                                <label class="blackfnt">
                                    <strong>
                                        &nbsp;WebXPress Rules - Step 4
                                    </strong>
                                </label>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White;">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt">
                                    Document
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upDocument" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlDocument" runat="Server"   
                                            cssclass="blackfnt" Width="100" AutoPostBack="true" OnSelectedIndexChanged="ddlDocument_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        &nbsp;
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt">
                                    Document Prefix
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upDocPrefixSize" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <%--<select id="selDocPrefixSize" runat="server" class="blackfnt">
                                            <option value="-1" selected="selected">Select</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                        </select>--%>
                                        <asp:DropDownList ID="ddlDocPrefixSize" runat="Server" 
                                            cssclass="blackfnt" Width="100" AutoPostBack="true" OnSelectedIndexChanged="ddlDocPrefixSize_SelectedIndexChanged">
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;&nbsp;
                                        <%--<input type="text" size="5" runat="server" id="txtDocPrefix" class="blackfnt" onblur="return ValidateDocumentPrefix()" />--%>
                                        <asp:TextBox ID="txtDocPrefix" Width="30" runat="server" CssClass="blackfnt" AutoPostBack="true" 
                                            OnTextChanged="txtDocPrefix_TextChanged"></asp:TextBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>    
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt">
                                    Year Code Required
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upYrCode" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlYearCode" runat="Server" 
                                            cssclass="blackfnt" Width="100" AutoPostBack="true" OnSelectedIndexChanged="ddlYearCode_SelectedIndexChanged">
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<select id="selYrCode" runat="server" class="blackfnt">
                                            <option value="-1" selected="selected">Select</option>
                                            <option value="Y">Yes</option>
                                            <option value="N">No</option>
                                        </select>--%>
                                        <label id="lblYrCodeReqNote" runat="server" class="bluefnt" >
                                            If Yes Then Document Running No. Will Get Reset Every Fin Year
                                        </label>
                                        &nbsp;
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt">
                                    Running No. Length
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upRunNoLength" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlRunNoLen" runat="Server" 
                                            cssclass="blackfnt" Width="100" AutoPostBack="true" OnSelectedIndexChanged="ddlRunNoLen_SelectedIndexChanged">
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<select id="selRunNoLen" runat="server" class="blackfnt">
                                            <option value="-1" selected="selected">Select</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                        </select>--%>
                                        &nbsp;
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt">
                                    Separator
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upSeparator" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlSeparator" runat="Server" 
                                            cssclass="blackfnt" Width="100" AutoPostBack="true" OnSelectedIndexChanged="ddlSeparator_SelectedIndexChanged">
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                            <asp:ListItem Text="/" Value="/"></asp:ListItem>
                                            <asp:ListItem Text="NULL" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<select id="selSeparator" runat="server" class="blackfnt">
                                            <option value="-1" selected="selected">Select</option>
                                            <option value="-">-</option>
                                            <option value="/">/</option>
                                            <option value="">NULL</option>
                                        </select>--%>
                                        &nbsp;
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt">
                                    Select Nomenclature
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upNomenclature" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlNomenclature" runat="Server" 
                                            cssclass="blackfnt" Width="250" >
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<select id="selNomenclature" runat="server" class="blackfnt">
                                            <option value="-1" selected="selected">Select</option>
                                        </select>--%>
                                        &nbsp;
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlDocument" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlDocPrefixSize" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlYearCode" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlRunNoLen" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlSeparator" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td align="center" colspan="2" nowrap>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return ValidateData()" 
                                    OnClick="btnSubmit_Click" />        
                            </td>
                        </tr>
                    </table> 
                </td>
                
                <td style="width: 5%">
                    &nbsp;
                </td>
            </tr>
        </table>
        
        <br />
	    
	    <center>                                            
            <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                <ProgressTemplate>
                    <div id="progressArea">
                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </center>
        
    </div>
    
</asp:Content>


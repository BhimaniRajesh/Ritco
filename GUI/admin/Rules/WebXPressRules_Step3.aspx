<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageSA.master" AutoEventWireup="true" CodeFile="WebXPressRules_Step3.aspx.cs" Inherits="GUI_admin_WebXPressRules_Step3" Title="WebXPress Rules - Step 3" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
            
    <script language="javascript">
                
        function disableenter()
        {
        
        }    
                
        function ValidateData()
        {
            //Check Docket Generation Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlDocketGeneration"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlDocketGeneration").value == "-1")
                {
                    alert("Please select " + document.getElementById("ctl00_MyCPH1_HidDocket").value + " Generation from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlDocketGeneration").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for " + document.getElementById("ctl00_MyCPH1_HidDocket").value + " Generation!");
                return false;
            }
            
            //Check LS Generation Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlLSGeneration"))
            {
                if (document.getElementById("ctl00_MyCPH1_ddlLSGeneration").value == "-1")
                {
                    alert("Please select " + document.getElementById("ctl00_MyCPH1_HidLS").value + " Generation from the list!");
                    document.getElementById("ctl00_MyCPH1_ddlLSGeneration").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list not available for " + document.getElementById("ctl00_MyCPH1_HidLS").value + " Generation!");
                return false;
            }
            
            //Check MF Generation Drop Down Selection
            if (document.getElementById("ctl00_MyCPH1_ddlDocketGeneration").value == "2")
            {
                if (document.getElementById("ctl00_MyCPH1_ddlMFGeneration"))
                {
                    if (document.getElementById("ctl00_MyCPH1_ddlMFGeneration").value == "-1")
                    {
                        alert("Please select " + document.getElementById("ctl00_MyCPH1_HidMF").value + " Generation from the list!");
                        document.getElementById("ctl00_MyCPH1_ddlMFGeneration").focus();
                        return false;
                    }
                }
                else
                {
                    alert("Selection list not available for " + document.getElementById("ctl00_MyCPH1_HidMF").value + " Generation!");
                    return false;
                }    
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
		                    WebXPress Rules - Step 3
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
                                        &nbsp;WebXPress Rules - Step 3
                                    </strong>
                                </label>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White;">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt" id="lblDocketGeneration" runat="server">
                                    <%--&nbsp;Docket Generation--%>
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upDocketGeneration" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlDocketGeneration" runat="Server"  AutoPostBack="true"  
                                            cssclass="blackfnt" Width="100" OnSelectedIndexChanged="ddlDocketGeneration_SelectedIndexChanged">
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Single Step" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Two Steps" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlDocketGeneration" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt" id="lblLSGeneration" runat="server">
                                    <%--&nbsp;LS Generation--%>
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                &nbsp;
                                <asp:DropDownList ID="ddlLSGeneration" runat="Server" 
                                    cssclass="blackfnt" Width="100">
                                    <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="Any" Value="A"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td style="width:30%;" align="left" nowrap>
                                <label class="blackfnt" id="lblMFGeneration" runat="server">
                                    <%--&nbsp;MF Generation--%>
                                </label>
                            </td>
                            
                            <td align="left" nowrap>
                                <asp:UpdatePanel ID="upMFGeneration" runat="server">
                                    <ContentTemplate>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlMFGeneration" runat="Server" 
                                            cssclass="blackfnt" Width="100" Visible="false">
                                            <asp:ListItem Text="Select" Value="-1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                        </asp:DropDownList>
                                        <label id="lblMFGenNA" runat="server" class="bluefnt" visible="false"></label>
                                        &nbsp;        
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlDocketGeneration" EventName="SelectedIndexChanged" />
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


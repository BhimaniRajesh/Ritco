<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="MainCustomerContractMaster.aspx.cs" Inherits="MainCustomerContractMaster" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

        <script language="javascript">
                
            function disableenter()
        {
        
        }    
                
            function checkCustomerSelection(mDDLNo)
            {
                if(mDDLNo == 1)
                {
                    //Called for Add Customer Contract Details
                    if (document.getElementById("ctl00_MyCPH1_ddlSelCustomerForAdd"))
                    {
                        if (document.getElementById("ctl00_MyCPH1_ddlSelCustomerForAdd").value == "Select")
                        {
                            alert("Please select customer from the list!");
                            document.getElementById("ctl00_MyCPH1_ddlSelCustomerForAdd").focus();
                            return false;
                        }
                        else
                        {
                            if (document.getElementById("ctl00_MyCPH1_btnAddCustomerContract"))
                            {
                                document.getElementById("ctl00_MyCPH1_btnAddCustomerContract").value = "Processing...";
                            }
                            
                            return true;
                        }
                    }
                }
                else if(mDDLNo == 2)
                {    
                    //Called for Edit Customer Contract Details
                    if (document.getElementById("ctl00_MyCPH1_ddlSelCustomerForEdit"))
                    {
                        if (document.getElementById("ctl00_MyCPH1_ddlSelCustomerForEdit").value == "Select")
                        {
                            alert("Please select customer from the list!");
                            document.getElementById("ctl00_MyCPH1_ddlSelCustomerForEdit").focus();
                            return false;
                        }
                        else
                        {
                            if (document.getElementById("ctl00_MyCPH1_btnEditCustomerContract"))
                            {
                                document.getElementById("ctl00_MyCPH1_btnEditCustomerContract").value = "Processing...";
                            }
                        }
                    }
                }
                else if(mDDLNo == 3)
                {   
                    //Called for View Customer Contract Details
                    if (document.getElementById("ctl00_MyCPH1_ddlSelCustomerForView"))
                    {
                        if (document.getElementById("ctl00_MyCPH1_ddlSelCustomerForView").value == "Select")
                        {
                            alert("Please select customer from the list!");
                            document.getElementById("ctl00_MyCPH1_ddlSelCustomerForView").focus();
                            return false;
                        }
                        else
                        {
                            if (document.getElementById("ctl00_MyCPH1_btnViewCustomerContract"))
                            {
                                document.getElementById("ctl00_MyCPH1_btnViewCustomerContract").value = "Processing...";
                            }
                            //alert("Yet to be implemented");
                            //return false;
                        }
                    }
                }
                
                return true;
            }
            
        </script>
            
            <center>
                <table cellpadding="1" cellspacing="1" border="0" width="100%">
                    
                    <tr>
			            <td colspan="3" align="left">
				            <label class="blackfnt">
				                <b>
				                    Customer Contract Master				            
				                </b>
				                <hr align="center" size="1" color="#8ba0e5">
				            </label>    
			            </td>
		            </tr>
                    
                    <tr>
                        <td style="width: 5%">
                            &nbsp;
                        </td>
                        
                        <td style="width: 90%">
                            <table cellpadding="1" cellspacing="1" class="boxbg" width="100%" border="0">
                                <%--Row for header--%>
                                <tr class="bgbluegrey" runat="server">
                                    <td colspan="4" align="center" style="height: 25px;" nowrap>
                                        <label class="blackfnt">
                                            <strong>
                                                &nbsp;Customer Contract Master</strong></label></td>
                                </tr>
                                
                                <%--Row for Add Contractor Master Information--%>
                                <tr style="background-color: White;" runat="server">
                                    <td align="center" valign="middle">
                                        <font class="bluefnt" size="25">
                                            <b>
                                                .
                                            </b>
                                        </font>
                                    </td>
                                    
                                    <td style="width:30%;" align="left" nowrap>
                                        <label class="blackfnt">
                                            &nbsp;Add New Contract Details</label></td>
                                    
                                    <td style="width:42%;" align="left" nowrap>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlSelCustomerForAdd" runat="Server"  
                                            cssclass="blackfnt" Width="300">
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                    
                                    <td>
                                        <asp:Button ID="btnAddCustomerContract" Text="Submit" runat="server" 
                                            ToolTip="Click here to add contract details for the selected customer" 
                                            OnClientClick="JavaScript:return checkCustomerSelection(1)" OnClick="btnAddCustomerContract_Click" />
                                    </td>
                                </tr>
                                
                                <%--Row for Edit Contractor Master Information--%>
                                <tr style="background-color: White" runat="server">
                                    <td align="center" valign="middle">
                                        <font class="bluefnt" size="25">
                                            <b>
                                                .
                                            </b>
                                        </font>
                                    </td>
                                    
                                    <td style="width:30%;" align="left" nowrap>
                                        <label class="blackfnt">
                                            &nbsp;Edit Contract Details</label></td>
                                    
                                    <td style="width:42%;" align="left" nowrap>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlSelCustomerForEdit" runat="Server" 
                                            cssclass="blackfnt" Width="300">
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                    
                                    <td>
                                        <%--<input type="button" value="Submit" ID="btnEditCustomerContract" 
                                            title="Click here to edit contract details for the selected customer" 
                                            onclick="JavaScript:checkCustomerSelection(2)" /> --%> 
                                        <asp:Button ID="btnEditCustomerContract" Text="Submit" runat="server" 
                                            ToolTip="Click here to edit contract details for the selected customer" 
                                            OnClientClick="JavaScript:return checkCustomerSelection(2)" OnClick="btnEditCustomerContract_Click" />      
                                    </td>
                                </tr>
                                
                                <%--Row for View Contractor Master Information--%>
                                <tr style="background-color: White" runat="server">
                                    <td align="center" valign="middle">
                                        <font class="bluefnt" size="25">
                                            <b>
                                                .
                                            </b>
                                        </font>
                                    </td>
                                    
                                    <td style="width:30%;" align="left" nowrap>
                                        <label class="blackfnt">
                                            &nbsp;View Contract Details</label></td>
                                    
                                    <td style="width:42%;" align="left" nowrap>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlSelCustomerForView" runat="Server" 
                                            cssclass="blackfnt" Width="300">
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                    
                                    <td>
                                        <%--<input type="button" value="Submit" ID="btnViewCustomerContract" 
                                            title="Click here to view contract details for the selected customer" 
                                            onclick="JavaScript:checkCustomerSelection(3)" />--%>
                                        <asp:Button ID="btnViewCustomerContract" Text="Submit" runat="server" 
                                            ToolTip="Click here to view contract details for the selected customer" 
                                            OnClientClick="JavaScript:return checkCustomerSelection(3)" OnClick="btnViewCustomerContract_Click" />
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
			                                                
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
        
            </center>
</asp:Content>

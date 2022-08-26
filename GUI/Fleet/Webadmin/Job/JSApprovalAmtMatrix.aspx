<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="JSApprovalAmtMatrix.aspx.cs" Inherits="GUI_Fleet_Webadmin_Job_JSApprovalAmtMatrix"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function createXMLHttpRequest() {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
            // IE
            else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
        }

        function CheckApproveUserID(txtApprove_UserId, lbl_JS_Error) {
            var currentTime = new Date()

            if (txtApprove_UserId.value == "") {
                lbl_JS_Error.innerText = "";
            }

            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function() 
                {
                    if (xmlHttpRequest.readyState == 4) 
                    {  
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "Y") {
                            var mEmailId = "";
                            mEmailId = returnValue[2];
                            //alert("mEmailId : " + mEmailId);
                            if (mEmailId == "" || mEmailId == null) {
                                lbl_JS_Error.innerText = " Invalid Users : " + returnValue[1] + "\r\n Enter Valid Users Which have Email ID";
                                txtApprove_UserId.focus();
                                return false;
                            }
                        }
                        else {
                            lbl_JS_Error.innerText = "";
                        }
                    }
                }
                xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckApprove_UserID&datetime=" + currentTime + "&UserId=" + txtApprove_UserId.value, false);
                xmlHttpRequest.send(null);
            }
        }

        //function CheckApproveUserEmailID(txtApprove_UserId,lbl_JS_Error)
        //{
        //    var currentTime = new Date()
        //    
        //    if (txtApprove_UserId.value == "")
        //    { 
        //       lbl_JS_Error.innerText=""; 
        //    } 
        //   
        //    createXMLHttpRequest();
        //    if (xmlHttpRequest)
        //    {
        //        xmlHttpRequest.onreadystatechange = function()
        //        {
        //            if (xmlHttpRequest.readyState == 4)
        //            {
        //                var returnValue=xmlHttpRequest.responseText.split("~");
        //                if (returnValue[0] == "Y") 
        //                {
        //                    var mEmailId="";
        //                    mEmailId=returnValue[2];
        //                    //alert("mEmailId : " + mEmailId);
        //                    if(mEmailId == "" || mEmailId == null)
        //                    {
        //                        lbl_JS_Error.innerText= " User Do not have Email ID : "+ returnValue[1] +" \r\n Enter Valid User which have Email ID";
        //                        txtApprove_UserId.focus();
        //                        return false;
        //                    }
        //                }
        //                else
        //                {
        //                   lbl_JS_Error.innerText=""; 
        //                }
        //            }
        //        }
        //       xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckApproveUserEmailID&datetime="+currentTime+"&UserId=" + txtApprove_UserId.value, false);
        //       xmlHttpRequest.send(null);     
        //    }
        //}

        function CheckCCUserID(txtCC_UserId, lbl_JS_PageError) {
            var currentTime = new Date()

            if (txtCC_UserId.value == "") {
                lbl_JS_PageError.innerText = "";
            }


            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function() {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "Y") {
                            var mEmailId = "";
                            mEmailId = returnValue[2];
                            //alert("mEmailId : " + mEmailId);
                            if (mEmailId == "" || mEmailId == null) {
                                lbl_JS_PageError.innerText = " Invalid Users : " + returnValue[1] + "\r\n Enter Valid Users Which have Email ID";
                                txtCC_UserId.focus();
                                return false;
                            }
                        }
                        else {
                            lbl_JS_PageError.innerText = "";
                            return true;
                        }
                    }
                }
                xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckCC_UserID&datetime=" + currentTime + "&UserId=" + txtCC_UserId.value, false);
                xmlHttpRequest.send(null);
            }

        }
        //function CheckCCUserEmailID(txtCC_UserId,lbl_JS_PageError)
        //{
        //    var currentTime = new Date()
        //    
        //    if (txtCC_UserId.value == "")
        //    {  
        //       lbl_JS_PageError.innerText=""; 
        //    } 
        //    
        //   
        //    createXMLHttpRequest();
        //    if (xmlHttpRequest)
        //    {
        //        xmlHttpRequest.onreadystatechange = function()
        //        {
        //            if (xmlHttpRequest.readyState == 4)
        //            {
        //                var returnValue=xmlHttpRequest.responseText.split("~");
        //                if (returnValue[0] == "Y") 
        //                {
        //                    var mEmailId="";
        //                    mEmailId=returnValue[2];
        //                    //alert("mEmailId : " + mEmailId);
        //                    if(mEmailId == "" || mEmailId == null)
        //                    {
        //                        lbl_JS_PageError.innerText= " User Do not have Email ID : "+ returnValue[1] +" \r\n Enter Valid User which have Email ID";
        //                        txtCC_UserId.focus();
        //                        return false;
        //                    }
        //                }
        //                else
        //                {
        //                    lbl_JS_PageError.innerText=""; 
        //                    return true;
        //                }
        //            }
        //        }
        //       xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckCCUserEmailID&datetime="+currentTime+"&UserId=" + txtCC_UserId.value, false);
        //       xmlHttpRequest.send(null);     
        //    }

        //}

    </script>

    <asp:UpdatePanel runat="server" ID="Up1">
        <ContentTemplate>
            <table cellspacing="1" style="width: 800px">
                <tr style="background-color: white">
                    <td align="left" style="height: 26px">
                        <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Jobsheet Approval Amount Matrix</asp:Label>
                        <hr align="center" color="#8ba0e5" size="1" />
                    </td>
                    <td align="right">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                <font class="blackfnt" color="red"><b>Please wait...</b></font>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table align="left" class="boxbg" cellspacing="2" width="600px">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center">
                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Jobsheet Approval Amount Matrix</asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td colspan="4" align="left">
                        <asp:Label ID="lbl_Page_Error" CssClass="redfnt" runat="server"></asp:Label>
                        <asp:HiddenField ID="hfTodayDate" runat="Server" />
                        <asp:Label ID="Label1" CssClass="redfnt" runat="server">Note : Enter Multiple Users Separated By Commas</asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td colspan="2">
                        <asp:GridView ID="gvApprovedAmtMatrix" runat="server" AutoGenerateColumns="False"
                            BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5" CellSpacing="1" CssClass="dgRowStyle"
                            Width="990px" OnRowDataBound="gvApprovedAmtMatrix_RowDataBound" HeaderStyle-CssClass="dgHeaderStyle"
                            PagerStyle-HorizontalAlign="left">
                            <Columns>
                                <asp:TemplateField HeaderText="Approver User Id">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="250px" />
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtApprove_UserId" CssClass="input" Width="250px" Style="text-align: left"
                                                        ForeColor="Gray" runat="server" BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem, "Approver_UserId") %>'></asp:TextBox>
                                                        <%--<ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                                                                    TargetControlID="txtApprove_UserId"
                                                                    WatermarkText="Enter Multiple Users Separated By Commas"
                                                                    WatermarkCssClass="watermarked" />--%>

                                                   
                                                </td>
                                                <td>
                                                    <asp:Button ID="btn_PopUp1" runat="server" Text="..." />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="lbl_JS_Error" CssClass="redfnt" runat="server"></asp:Label>
                                        <asp:HiddenField ID="hfApproved_Id" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Approved_Id") %>' />
                                        <asp:HiddenField ID="hfId" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Id") %>' />
                                        <asp:HiddenField ID="hfJobID" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Job_ID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CC UserId">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="250px" />
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtCC_UserId" CssClass="input" Width="250px" Style="text-align: left"
                                                        ForeColor="Gray" runat="server" BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem, "CC_UserId") %>'></asp:TextBox>
                                                        <%-- <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server"
                                                                    TargetControlID="txtCC_UserId"
                                                                    WatermarkText="Enter Multiple Users Separated By Commas"
                                                                    WatermarkCssClass="watermarked" />--%>
                                                  

                                                </td>
                                                <td>
                                                    <asp:Button ID="btn_PopUp2" runat="server" Text="..." />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="lbl_JS_PageError" CssClass="redfnt" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="JS_TYPE" HeaderText="Job Sheet Type">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="120px" />
                                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="LOC_APPROVE_AMT" HeaderText="Approved Amount">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="120px" />
                                    <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="HRCHYDESC" HeaderText="Location Hierarchy">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="120px" />
                                    <ItemStyle Width="120px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                 <tr style="background-color: white" align="left">
                    <td align="center" colspan="2" style="width: 734px">
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClick="cmdSubmit_Click" />
                    </td>
                </tr>
                <tr style="background-color: white" align="center">
                    <td align="center" colspan="2" style="width: 734px">
                        <asp:Label ID="lbl_button_Page" CssClass="bluefnt" Font-Size="Medium" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

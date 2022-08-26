<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectRegStateSub2.aspx.cs" Inherits="SFM_ProspectRegStateSub2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">

function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "StatusSubmission_View1.aspx?strProspectCode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenPopupWindow(prospectcode)
      {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "StatusSubmission_View1.aspx?strProspectCode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
//        function CheckProspectSelection(txtProspect_Id,txtProspectListCount,btnSubmit)
//        {
//            //Get count of records fetched
//            
//            var mTotalRecords = "<%=intTotalRecords %>"
//            //Get the selected control Name
//            //Will store dynamically generated control name
//            var mDerivedControlName = "";
////            var mDerivedControlNameForCompanyStatus = "";
////            var mDerivedControlNameForStatus = "";
//            var mSelection = 0;
//            var j = 0;
//            var mSelectedDockets = "";
//                
//            //Loop through the records
//            for (var i=0; i < mTotalRecords; i++)
//            {
//                j = i + 2;
//                if(i < 10)
//                {
//                
//                      mDerivedControlName = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$chkDock"
//                    //mDerivedControlName = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$chkDock"
//                    //mDerivedControlNameForCompanyStatus = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$cboSubmit"
//                    //mDerivedControlNameForStatus = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$cboStatus"
//                }
//                else
//                {
//                    mDerivedControlName = "ctl00$MyCPH1$ProspectStatus$ctl" +  j + "$chkDock"
//                    //mDerivedControlName = "ctl00$MyCPH1$ProspectStatus$ctl" + j + "$chkDock"
//                    //mDerivedControlNameForCompanyStatus = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$cboSubmit"
//                    //mDerivedControlNameForStatus = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$cboStatus"
//                }
//                
//                //Populate Docket No.s for Preaparing Loading Sheet
//                if(document.getElementById(mDerivedControlName))
//                {
//                    if(document.getElementById(mDerivedControlName).checked == true)
//                    {
//                       
//                       // mSelection=mSelection+1
//                         if(mSelection == 0)
//                        {
//                            mSelection = 1;
//                        }
//                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
////                        if(document.getElementById(mDerivedControlNameForCompanyStatus))
////                        {
////                            if(document.getElementById(mDerivedControlNameForCompanyStatus).value == "")
////                            {
////                                alert("Select Company Status from the List!");
////                                document.getElementById(mDerivedControlNameForCompanyStatus).focus();
////                                return false;
////                            }   
////                        }
////                        
////                        if(document.getElementById(mDerivedControlNameForStatus))
////                        {
////                            if(document.getElementById(mDerivedControlNameForStatus).value == "")
////                            {
////                                alert("Select Status from the List!");
////                                document.getElementById(mDerivedControlNameForStatus).focus();
////                                return false;
////                            }
////                        }
//                    }
//                }
//            }
//            
//            if(mSelection == 0)
//            {
//                alert("Select atleast one Document for Generate Bill....!");
//                
//                return false;
//            }
//            //txtProspect_Id.value = mSelection
//           // txtProspectListCount.value = mSelectedDockets
//            document.getElementById("ctl00_MyCPH1_txtProspectListCount").value=mSelection;
//            document.getElementById("ctl00_MyCPH1_txtProspect_Id").value=mSelectedDockets;
//           //alert("hi-" +  document.form1.txtdocketlist.value)
//            
//            return true;
//        }


function CheckDocketSelection(txtdocketlist,txtdocketlist_count)
        {
            //Get count of records fetched
           
            var mTotalRecords = "<%=intTotalRecords %>"
            //Get the selected control Name
            //Normally, ID and Name values are same
            //var mSelectedControlName = objBranch.name;
            //Will store dynamically generated control name
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
                //alert(mTotalRecords)
            //Loop through the records
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
            
                if(i < 10)
                {
                
                    mDerivedControlName = "ctl00$MyCPH1$ProspectStatus$ctl" + "0" + j + "$chkDock"
                    //alert(mDerivedControlName)
                    
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$ProspectStatus$ctl" + j + "$chkDock"
                    
                }
                
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select the prospect for Approval");
                
                return false;
            }
//            document.form1.txtdocketlist_count.value=mSelection
//           document.form1.txtdocketlist.value=mSelectedDockets;
            document.getElementById("ctl00_MyCPH1_txtdocketlist_count").value=mSelectedDockets;
            document.getElementById("ctl00_MyCPH1_txtdocketlist").value=mSelection;
//            txtdocketlist.value=mSelection
//            txtdocketlist_count.value=mSelectedDockets;
           //alert("hi-" +  document.form1.txtdocketlist.value)
            
            return true;
        }
</script>

<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Status and Submission" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
            
            
            <asp:GridView align="center" ID="ProspectStatus" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" Width="100%" OnRowDataBound="ProspectStatus_RowDataBound">
                <Columns >
                   <asp:TemplateField>
                                <ItemTemplate>
                                    <center>
                                    <asp:CheckBox ID="chkDock" runat="server" AutoPostBack="false" value='<%# DataBinder.Eval(Container.DataItem,"ProspectCode") %>' />
                                    <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"ProspectCode") %>' />--%>
                                    </center>
                                </ItemTemplate>
                    </asp:TemplateField>

                    <%--<asp:BoundField DataField="ProspectCode" HeaderText="Id*"  HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>--%>
                    
                    <asp:TemplateField HeaderText="Id*" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass = "blackfnt">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>
                                            <asp:Label ID="lblProspect" Text='<%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>' runat="server" CssClass="blackfnt" Visible="false"></asp:Label>  
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    <asp:TemplateField HeaderText="Company*" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass = "blackfnt">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt"  />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "companyName")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    
                    

                   <%-- <asp:BoundField DataField="companyName" HeaderText="Company*" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
--%>
                    <asp:BoundField DataField="compCity" HeaderText="City" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="contPerson" HeaderText="Sales Manager" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="industryCode" HeaderText="Industry" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="RegisterDt" HeaderText="Registration date" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <asp:BoundField DataField="LastVisitDt" HeaderText="Last Visit Date" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                   <%-- <asp:TemplateField HeaderText="Submission Status" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                        <asp:DropDownList ID="cboSubmit" runat="server">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Unsubmitted" Value="U"></asp:ListItem>
                                        <asp:ListItem Text="Submitted" Value="S"></asp:ListItem>
                                        <asp:ListItem Text="Rejected" Value="R"></asp:ListItem>
                                        </asp:DropDownList>--%>
                                          <%--<select name="companyStatus1">
			                                <option value="">Select
			                                <option value="U" > Unsubmitted</option>
			                                <option value="S" > Submitted</option>
			                                <option value="R" > Rejected</option>
			                              </select>
                                        </center>
                                    </ItemTemplate>
                         </asp:TemplateField>--%>
                        
                    <%--<asp:BoundField DataField="companyStatus" HeaderText="Submission Status" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>--%>
                    
                    
                    <asp:TemplateField HeaderText="Submission Status" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="blackfnt">
                    <ItemTemplate>
                    <asp:Label ID="lblsubmission" Text='<%#DataBinder.Eval(Container.DataItem, "statesub")%>' runat="server" CssClass="blackfnt"></asp:Label>  
                    </ItemTemplate> 
                    </asp:TemplateField> 
                         
                    <asp:BoundField DataField="comment" HeaderText="Remarks" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="ReasonforReject" HeaderText="Reason For Rejected" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>

                    <%--<asp:TemplateField HeaderText="Submission Status" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                        <asp:DropDownList ID="cboStatus" runat="server">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Hot" Value="Hot"></asp:ListItem>
                                        <asp:ListItem Text="Warm" Value="Warm"></asp:ListItem>
                                        <asp:ListItem Text="Cold" Value="Cold"></asp:ListItem>
                                        </asp:DropDownList>
                                        </center>
                                    </ItemTemplate>
                         </asp:TemplateField>--%>


                    <asp:BoundField DataField="acctCategory" HeaderText="Status" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:TemplateField HeaderText="View Contract" HeaderStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">
                            <font class="Blackfnt">View Contract </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                     
                </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                    />
                    <FooterStyle CssClass="boxbg" />
            </asp:GridView>
<br />
        <asp:HiddenField ID="txtdocketlist" runat="server" />
        <asp:HiddenField ID="txtdocketlist_count" runat="server" />
<asp:Button ID="btnSubmit" runat="server" Text="Submit for Approval" OnClientClick="return CheckDocketSelection()" OnClick="btnSubmit_Click1" />
            </div>
            
            
            
            </asp:Content>

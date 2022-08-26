<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmMRDetail.aspx.cs" Inherits="GUI_Finance_MoneyRecipt_Updatemr_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        
        function OpenInWindow(MR_Number) 
        { 
            //debugger
            window.open("MR_Summ_Popup.aspx?mrsno=" + MR_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            return false
        }
        function CheckDocketSelection(txtdocketlist,txtdocketlist_count)
        {
            //Get count of records fetched
           // alert(txtdocketlist_count)
            //return false;
            var mTotalRecords = "<%=intTotalRecords %>"
            //Get the selected control Name
            //Normally, ID and Name values are same
            //var mSelectedControlName = objBranch.name;
            //Will store dynamically generated control name
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
                
            //Loop through the records
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
                if(i < 10)
                {
                    mDerivedControlName = "ctl00$MyCPH1$GV_Booking$ctl" + "0" + j + "$chkDock"
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$GV_Booking$ctl" + j + "$chkDock"
                }
                
                //Populate Docket No.s for Preaparing Loading Sheet
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
                alert("Select atleast one docket to prepare loading sheet!");
                return false;
            }
            txtdocketlist_count.value=mSelection
            txtdocketlist.value=mSelectedDockets;
          //alert("hi-" +  document.form1.txtdocketlist_count.value)
            
            return true;
        }
        
    </script>

    <table cellspacing="1" style="width: 800px; height: 100%;" border="0" align="left">
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="left">
                <font class="blackfnt"><b><a href="../../welcome.aspx"><font class="blklnkund"><strong>
                    Module</strong></font></a><strong> &gt; </strong></font><a href="#"><font class="blklnkund">
                        <strong>Finance</strong> </font></a>&gt; <font class="bluefnt"><strong>MR View/Print
                        </strong></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0"></a>
            </td>
        </tr>
        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr>
            <td colspan="2">
                <img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr align="center">
            <td style="height: 100%" align="center" colspan="3">
                <table cellspacing="1" cellpadding="3" style="width: 800px" class="boxbg" border="0"
                    align="center">
                    <tr bgcolor="white" style="height: 25px">
                        <td colspan="2" align="center" style="height: 25px">
                            <font class="blackfnt"><b>You Selected </b></font>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff" align="center">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date :
                            </label>
                        </td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff" align="center">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Mrs Type :
                            </label>
                        </td>
                        <td style="height: 10px">
                            <asp:Label ID="lbl_mrstype" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff" align="center">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                MrsNo :
                            </label>
                        </td>
                        <td style="height: 10px">
                            <asp:Label ID="str_mrsno" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff" align="center">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Docket No :
                            </label>
                        </td>
                        <td style="height: 10px">
                            <asp:Label ID="Str_dockno" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <label class="blackfnt">
                    <b>MRs List </b>
                </label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" Width="10in"
                    CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="true"
                    PageSize="25" OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                    OnRowDataBound="GV_Booking_RowDataBound">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <%--<asp:TemplateField>
                            <ItemTemplate>
                                <center>
                                    <input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"mrsno") %>' />
                                    <%--  <asp:CheckBox id="chkDock" runat="server"   />
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <%--   <asp:BoundField  DataField="MRSNO"   ItemStyle-Wrap="False"  HeaderText="MR. No"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                        <%--<asp:BoundField DataField="DOckno" HeaderStyle-Font-Bold="true" ItemStyle-Wrap="False"
                            HeaderText="Docket No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>--%>
                        <asp:TemplateField HeaderText="MR NO. " HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <label class="blackfnt">
                                    <%--<asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='javascript:OpenPopup("<%DataBinder.Eval(Container.DataItem, "mrsno")%>")'  Text= '<%#DataBinder.Eval(Container.DataItem, "mrsno")%>' ID="Hyperlink3"/>--%>
                                    <%--<a href="Javascript:OpenInWindow('<%#DataBinder.Eval(Container.DataItem, "mrsno")%>')"
                                        id="Hyperlink3">
                                        <%#DataBinder.Eval(Container.DataItem, "mrsno")%>
                                    </a>--%>
                                    <asp:LinkButton ID="lnkpop" runat="server" Text='<%# Eval("mrsno") %>'></asp:LinkButton>
                                    <asp:Label ID="lblpop" runat="server" Text='<%# Eval("mrsno") %>' Visible="true"></asp:Label>
                                </label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MR No" Visible="false" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblmrnohidden" runat="server" Text='<%# Eval("mrsno") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MR Date" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblmrsdt" runat="server" Text='<%# Eval("mrsdt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MR Type" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblmrstype" runat="server" Text='<%# Eval("mrstype") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ptname" HeaderStyle-Font-Bold="true" ItemStyle-Wrap="false"
                            HeaderText="MR Party">
                            <HeaderStyle HorizontalAlign="Center" Width="300" CssClass="blackfnt" />
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MRSamt" HeaderStyle-Font-Bold="true" ItemStyle-Wrap="False"
                            HeaderText="MR Amount ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="deduction" HeaderStyle-Font-Bold="true" ItemStyle-Wrap="False"
                            HeaderText="Deduction">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="netamt" HeaderStyle-Font-Bold="true" ItemStyle-Wrap="False"
                            HeaderText="Net Amount ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <%--<asp:BoundField DataField="FINCLOSEDT" HeaderStyle-Font-Bold="true" ItemStyle-Wrap="False"
                            HeaderText="CBS Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>--%>
                        <asp:TemplateField HeaderText="CBS Date" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblcbsdt" runat="server" Text='<%# Eval("finclosedt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
        <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
            ForeColor="Red" Text="Label" Visible="False"></asp:Label><%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%><%--  <table border="0" cellpadding="0" width="565" style="background-color: #808080;" cellspacing="0" align="center" class="boxbg">
                                                                <tr align="center">   
                                                                <td style="background-color: #ffffff">
                                                                
                                                                <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First" >
                                                                </asp:LinkButton>
                                                                </td>                                                             
                                                                <td style="background-color: #ffffff">
                                                                
                                                                <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                                                                </asp:LinkButton>
                                                                </td>
                                                                
                                                                </tr>
                                                                 <tr align="center" style="background-color: #ffffff">
			                                                    <asp:Button   class="btncolor"   runat="server" id="Button1" onclick="Button1_Click" /></tr>
                                                                </table>--%><tr align="left">
                                                                    <td>
                                                                        <%--<table width="10in" align="center">
                    <tr>
                        <td>
                            <center>
                                <asp:Button ID="Button1" runat="server" CssClass="blackfnt" Text="Click Here to Update MRs"
                                    OnClick="Button1_Click" /></center>
                        </td>
                    </tr>
                </table>--%>
                                                                    </td>
                                                                </tr>
        <asp:HiddenField ID="txtdocketlist" runat="server" />
        <asp:HiddenField ID="txtdocketlist_count" runat="server" />
    </table>
</asp:Content>

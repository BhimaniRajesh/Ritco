<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="DocumentEntry.aspx.cs" Inherits="DocumentEntry" %>



   <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
       <script type="text/javascript" language="javascript" src="AJAX_Validator/js_Document.js"></script>
<script language="javascript" type="text/javascript">
  
  </script>
 
<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
        <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
        <img src="../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div align="left">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Document Entry</asp:Label>
                
                
            </td>
        </tr>
    </table>
    
<asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>
    <table id="Table3" runat="server" border="0" class="boxbg" cellpadding="1" cellspacing="1" style="width: 70%">
        <tr bgcolor="white">
            <td class="blackfnt" colspan="2" style="width: 38px"><strong style="width: 30%">
                <asp:Label ID="Label1" runat="server" Text="Enter Vehicle Number:" Width="154px" Font-Bold="False"></asp:Label></strong></td>
            <td align="left" class="blackfnt" colspan="2" style="width: 70%">
                <asp:TextBox ID="txtVehNo" runat="server" AutoCompleteType="Notes" Width="140px"></asp:TextBox>
                <asp:Button ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
               
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtVehNo"
                ServicePath="../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetVehNo"
                MinimumPrefixLength="1" 
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="20"
                CompletionListCssClass="autocomplete_completionListElement" 
                CompletionListItemCssClass="autocomplete_listItem" 
                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                DelimiterCharacters=";, :"
                ShowOnlyCurrentWordInCompletionListItem="true" >
                <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
                
                <asp:HiddenField ID="hfVehcate" runat="server" />
                <asp:HiddenField ID="hfVehType" runat="server" />
                <asp:HiddenField ID="hfKm" runat="server" />
                 
            </td>
        </tr>
      
     
        <tr bgcolor="white">
            <td class="blackfnt" colspan="2" style="width: 38px; height: 18px">
                <asp:Label ID="Label4" runat="server" Text="Select Document Type:" Width="154px"></asp:Label></td>
            <td align="left" class="blackfnt" colspan="2" style="width: 70%; height: 18px">
                <asp:DropDownList ID="ddlDocumentType" runat="server" Width="158px" AutoPostBack="True" OnSelectedIndexChanged="ddlDocumentType_SelectedIndexChanged">
                </asp:DropDownList></td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="4" style="height: 18px; text-align: right">
                </td>
        </tr>
    </table>
    <asp:HiddenField ID="hfVehIntId" runat="server" />
    <asp:HiddenField ID="hfDoctype" runat="server" /><asp:HiddenField ID="hfStateWise" runat="server" />
    <asp:HiddenField ID="hfCost" runat="server" />

       </ContentTemplate>
    </asp:UpdatePanel>
    
         <table runat="server"  id="Table5" border="0"  class="boxbg" cellpadding="1" cellspacing="1" width="70%">
        <tr bgcolor="#eeeeee">
            <td class="blackfnt" colspan="1" style="vertical-align: middle; height: 20px; text-align: center; width: 100%;">
                <asp:Button ID="btnSumit" runat="server" Text="Submit" OnClientClick="javascript:return ValidationDocMstEntry()"  OnClick="btnSumit_Click" /></td>
        </tr>
    </table>


    <br />
     <table cellpadding="3" cellspacing="1" style="width: 70%" border="0">
        <tr>
           <td class="blackfnt"  style="font-weight: bold; height: 20px; text-align: right;" colspan="4">
               <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/back.gif"
                   OnClick="ImageButton1_Click" /></td>
        </tr>
         <tr>
             <td class="blackfnt" colspan="4" style="font-weight: bold; height: 20px; text-align: right">
             </td>
         </tr>
        </table>
    <br />
    
    
    <table  id="Table1" runat="server" class="boxbg"  cellpadding="3" cellspacing="1" style="width: 70%" border="0">
        <tr>
           <td class="blackfnt"  style="font-weight: bold; height: 20px;" colspan="4">
               Document Information</td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt"  style="width: 25%">
                <asp:Label ID="Label5" runat="server" Font-Bold="False" Text="Vehicle Number:" Width="118px"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
                <asp:Label ID="lblVehNo" runat="server" Font-Bold="False" Width="100%"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
                <asp:Label ID="Label6" runat="server" Font-Bold="False" Text="Vehicle Type:" Width="118px"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
                <asp:Label ID="lblVehType" runat="server" Font-Bold="False" Width="100%"></asp:Label></td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" style="width: 25%">
            <asp:Label ID="Label7" runat="server" Font-Bold="False" Text="Document Type:" Width="118px"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
            <asp:Label ID="lblDocType" runat="server" Font-Bold="False" Width="100%"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
            <asp:Label ID="Label8" runat="server" Font-Bold="False" Text="Document Description:"
                Width="143px"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
            <asp:Label ID="lblDocDesc" runat="server" Font-Bold="False" Width="100%"></asp:Label></td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" style="width: 25%">
            <asp:Label ID="Label9" runat="server" Font-Bold="False" Text="Renewal Authority:"
                Width="120px"></asp:Label></td>
            <td class="blackfnt"  style="width: 25%">
            <asp:Label ID="lblRenewAutu" runat="server" Font-Bold="False" Width="100%"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
            <asp:Label ID="Label10" runat="server" Font-Bold="False" Text="Reminder in days before expiry:"
                Width="203px"></asp:Label></td>
            <td class="blackfnt" style="width: 25%">
            <asp:TextBox ID="txtReminderInDays" onkeydown="return numeric(event)" runat="server" Width="74px"></asp:TextBox>
                <asp:HiddenField ID="hfDocId" runat="server" />
            </td>
        </tr>
    </table>
    <br />
    
     <table id="Table4" runat="server" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">

<tr>
           <td class="blackfnt"  style="font-weight: bold; height: 19px;" colspan="1">
               Renewal History</td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="vertical-align: top; text-align: left;" >
   

                        <asp:GridView  OnRowUpdating="gvDocuTypeDet_RowAdding" ID="gvDocuTypeDet" runat="server" CellPadding="3" CellSpacing="1" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="gvDocuType_RowDataBound"  Width="100%" OnRowCancelingEdit="gvDocuTypeDet_RowCancelingEdit" OnRowEditing="gvDocuTypeDet_RowEditing" OnRowUpdated="gvDocuTypeDet_RowUpdated" OnRowDeleting="gvDocuTypeDet_RowDeleting">
                            <Columns>
                                <asp:TemplateField HeaderText="Document No">
                                <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentNo" Text='<%# Eval("DOCUMENT_NO") %>' runat="server"></asp:Label>&nbsp;
                                        <asp:HiddenField ID="hf_DocDetId" runat="server" Value='<%# Eval("DOCU_DET_ID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDocumnetNo" Text='<%# Eval("DOCUMENT_NO") %>'  class="input" runat="server" MaxLength="50" Width="95px"></asp:TextBox><asp:HiddenField ID="hfDocMstId" runat="server" />
                                        <asp:HiddenField ID="hf_DocDetId" runat="server" Value='<%# Eval("DOCU_DET_ID") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Renewal authority name">
                                <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRenewAutuName" Text='<%# Eval("RENEWAL_AUTU_NAME") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle  HorizontalAlign="Left" Width="10%" />
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtRenewAutuName" Text='<%# Eval("RENEWAL_AUTU_NAME") %>' class="input" runat="server" MaxLength="1000" Width="157px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Start Date">
                                <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                        <asp:Label ID="lblStartDt" Text='<%# Eval("START_DT") %>' runat="server"></asp:Label>
                                       
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtStartDt"  Text='<%# Eval("START_DT") %>' class="input" runat="server" Width="80px"></asp:TextBox>
                                    <%--    <asp:Image ID="img_CalendarSt" runat="server" BackColor="White" BorderColor="White"
                                            ForeColor="White" ImageUrl="~/cal/cal.gif" />--%>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtStartDt"   runat="server">
                                        </ajaxToolkit:CalendarExtender>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                              
                                
                                <asp:TemplateField HeaderText="Expiry Date" >
                                    <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpityDt" Text='<%# Eval("EXPRITY_DT") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                    <EditItemTemplate>
                                       <asp:TextBox ID="txtExpityDt"  Text='<%# Eval("EXPRITY_DT") %>' class="input" runat="server" Width="80px"></asp:TextBox>
                                       <%--<asp:Image ID="img_CalendarEx" runat="server" BackColor="White" BorderColor="White"
                                            ForeColor="White" ImageUrl="~/cal/cal.gif" />
                                       --%>      <ajaxToolkit:CalendarExtender ID="calExtenderExpirtyDt" 
                                             Format="dd/MM/yyyy"
                                             TargetControlID="txtExpityDt"   runat="server">
                                        </ajaxToolkit:CalendarExtender>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                 
                                 <asp:TemplateField HeaderText="Cost">
                                 <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                       <asp:Label ID="lblCost" Text='<%# Eval("DOCU_COST") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                     <ItemStyle  Width="5%" HorizontalAlign="Right" />
                                     <EditItemTemplate>
                                 <asp:TextBox ID="txtCost" onkeydown="return numeric(event)" Text='<%# Eval("DOCU_COST") %>' class="input" runat="server" Width="48px"></asp:TextBox>
                                     </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="State">
                                <ItemStyle VerticalAlign="Top" />  
                                <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblState" Text='<%# Eval("STATE") %>' runat="server"></asp:Label>
                                      </ItemTemplate>
                                    <ItemStyle Width="20%" />
                                    <EditItemTemplate>
                                         <div style="overflow:auto;width:250px;height:75px;border:1px solid #336699;padding-left:5px">
                                             <asp:CheckBoxList ID="chklstState" runat="server" CellPadding="0" CellSpacing="1" Font-Names="Verdana" Font-Size="8pt" Width="225px">
                                             </asp:CheckBoxList>
                                         </div>

                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Scan">
                                <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                       <asp:HyperLink ID="hyperView" Text="view" runat="server" 
                                        Target="_blank"  NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"FILENAME","DownloadFile1.aspx?FileName={0}" ) %>' ToolTip='<%# Eval("FILENAME") %>' ></asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                    <EditItemTemplate>
                                    
                                        <input id="FileUpload1" runat="server" type="file" onChange="return ValidFile()" name="elementName" />
                                        
                                    </EditItemTemplate>
                                    <ControlStyle ForeColor="Blue" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Remarks">
                                <ItemStyle VerticalAlign="Top" />  
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRamarks" Text='<%# Eval("REMARKS") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                    <EditItemTemplate>
                                       <asp:TextBox ID="txtRamarks"  Text='<%# Eval("REMARKS") %>' class="input" runat="server" Width="102px" MaxLength="1000"></asp:TextBox>
                                      
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Entry By">
                                <ItemStyle VerticalAlign="Top" />  
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblEnterby" Text='<%# Eval("ENTER_BY") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                    <EditItemTemplate>
                                       <asp:TextBox ID="txtEnterBy"  Text='<%# Eval("ENTER_BY") %>' class="input" runat="server" Width="102px" MaxLength="1000"></asp:TextBox>
                                      
                                    </EditItemTemplate>
                                
                                
                                </asp:TemplateField>
                                
                               <asp:TemplateField ShowHeader="False">
                                <ItemStyle VerticalAlign="Top" />  
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" Visible="false"  OnClientClick="javascript:return ValidationDocDetEntry()" runat="server" CausesValidation="False" CommandName="Edit"
                                            Text="Edit"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" Visible="false" CausesValidation="False" CommandName="Delete"
                                            Text="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" Visible="false" OnClientClick="javascript:return ValidationDocDetEntry()" runat="server" CausesValidation="True" CommandName="Update"
                                            Text="Update"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" Visible="false" CausesValidation="False" CommandName="Cancel"
                                            Text="Cancel"></asp:LinkButton>
                                    </EditItemTemplate>
                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                      
 
            </td>
        </tr>
    </table>

  <br />

   

    <br />
<%--</ContentTemplate>
                </asp:UpdatePanel>--%>
    <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
</div>
</asp:Content>
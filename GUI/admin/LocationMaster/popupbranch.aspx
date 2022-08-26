<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupbranch.aspx.cs" Inherits="popupbranch" %>


<link href="../../../GUI/admin/LocationMaster/include/style.css" rel="stylesheet"
    type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BranchList</title>
    
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation) {
            var mNo = document.getElementById("hdnstrQSParam").value;

            if(mNo == 1)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtAcLoc.value = objLocation.value
            }
            else if(mNo == 2)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtDataLoc.value = objLocation.value
            }
            else if(mNo == 3)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtNxtLoc.value = objLocation.value
            }
            else if(mNo == 4)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtNrPrLoc.value = objLocation.value
            }
        }
        function checkone(obj)
        {
            var rows = document.getElementById("GridView1").rows.length
            for(i=0;i<rows-1;i++)
            {
                j = i+2
                if(j<10)
                {
                    document.getElementById("GridView1_ctl0"+j+"_radselect").checked = false 
                }
                else
                {
                    document.getElementById("GridView1_ctl"+j+"_radselect").checked = false 
                }
            }
            obj.checked = true
        }
        var count=0
        var locval = ""
        var f = 0
        function dataenryloc()
        {
            //debugger
            var rows = document.getElementById("GridView1").rows.length
            for(i=0;i<rows-1;i++)
            {
                j = i+2
                if(j<10)
                {
                    if (document.getElementById("GridView1_ctl0"+j+"_radselect").checked == true)
                    {
                        //debugger
                        if (j == f)
                        {
                            continue
                        }
                        count+=1
                        locval = locval + "," + document.getElementById("GridView1_ctl0"+j+"_radselect").value
                        f = j
                        if (count >= 2)
                        {
                            locval = locval.substr(1,locval.length-1)
                            window.opener.document.forms[0].ctl00$MyCPH1$txtDataLoc.value = locval
                            window.close()
                            break
                        }
                        else
                        {
                            window.opener.document.forms[0].ctl00$MyCPH1$txtDataLoc.value = document.getElementById("GridView1_ctl0"+j+"_radselect").value
                        }
                    } 
                }
                else
                {
                    if (document.getElementById("GridView1_ctl"+j+"_radselect").checked == true)
                    {
                        if (j == f)
                        {
                            continue
                        }
                        count+=1
                        locval = locval + "," + document.getElementById("GridView1_ctl"+j+"_radselect").value                       
                        f = j
                        if (count >= 2)
                        {
                            locval = locval.substr(1,locval.length-1)
                            window.opener.document.forms[0].ctl00$MyCPH1$txtDataLoc.value = locval
                            window.close()
                            break
                        }
                        else
                        {
                            window.opener.document.forms[0].ctl00$MyCPH1$txtDataLoc.value = document.getElementById("GridView1_ctl"+j+"_radselect").value
                        }
                    }
                }
            }
        }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="350px" class="boxbg" OnRowDataBound="GridView1_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px" >
                                    <ItemTemplate>
                                        <%--<input name="MyRadioButton" type="radio" value='<%# Eval("loccode") %>' visible="false" onclick="SelectLocation(this)"/>--%>
                                        <asp:RadioButton id="radselect" value='<%# Eval("loccode") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="loccode" HeaderText="Branch Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="locname" HeaderText="Branch Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:HiddenField ID="hdnstrQSParam" runat="server" />
                   
        &nbsp;
    <div>
        &nbsp;</div>
    </form>
</body>
</html>


                             
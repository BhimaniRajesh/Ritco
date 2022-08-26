// JScript File
function valid(obj,dlstCategory,txtGroupCode,txtGroupDesc)
{   
    if (dlstCategory.value == '')
    {
        alert("Please Select Group Category !!")
        return false;
    }
    else if(txtGroupCode.value == '')
    {
        alert("Please Enter Group Code !!")
        return false;
    }
    else if (txtGroupDesc.value == '')
    {
        alert("Please Enter Group Desc. !!")
        return false;
    }
}
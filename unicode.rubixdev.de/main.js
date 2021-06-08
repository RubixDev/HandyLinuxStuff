function copyText(text) {
    const temp = document.createElement('textarea');
    temp.innerHTML = text;
    document.body.appendChild(temp);
    temp.select();
    temp.setSelectionRange(0, 99999);
    document.execCommand('copy');
    document.body.removeChild(temp)
}

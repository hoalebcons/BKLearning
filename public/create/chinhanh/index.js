$('#TAB-students').DataTable({
    "responsive": true, "lengthChange": false, "autoWidth": false, "searching": false, "bPaginate": false, "dom": "lfrti",
    "scrollY":        "600px",
    language: {
        url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
    } ,
    columnDefs: [
        { orderable: false,
             targets: 5
            }
      ]
    })
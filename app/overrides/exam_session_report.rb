Deface::Override.new(virtual_path: 'gaku/shared/grading/grading',
                     name: 'generate_reports_menu',
                     insert_bottom: '#generate-report',
                     partial: 'gaku/courses/exams/generate_select',
                     disabled: false
                     )

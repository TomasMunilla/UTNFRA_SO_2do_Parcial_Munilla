cd /home/repogit/UTN-FRA_SO_Examenes/202406/ansible
sudo vim playbook.yml
- name: Crear archivos de datos
  hosts: all
  become: yes

  tasks:
    - name: Crear el directorio de alumnos
      file:
        path: "/home/repogit/UTN-FRA_SO_Examenes/202406/ansible/tmp/2do_parcial/alumno"
        state: directory

    - name: Crear el directorio de equipos
      file:
        path: "/home/repogit/UTN-FRA_SO_Examenes/202406/ansible/tmp/2do_parcial/equipo"
        state: directory

    - name: Crear el archivo datos_alumno.txt
      template:
        src: datos_alumno.j2
        dest: "/home/repogit/UTN-FRA_SO_Examenes/202406/ansible/tmp/2do_parcial/alumno/datos_alumno.txt"

    - name: Crear el archivo datos_equipo.txt
      template:
        src: datos_equipo.j2
        dest: "/home/repogit/UTN-FRA_SO_Examenes/202406/ansible/tmp/2do_parcial/equipo/datos_equipo.txt"
    - name: Configurar sudo sin contraseña para 2PSupervisores
      become: yes
      lineinfile:
        path: /etc/sudoers
        regexp: '^%2PSupervisores\s+ALL=(ALL:ALL)'
        line: '%2PSupervisores ALL=(ALL:ALL) NOPASSWD: ALL'
        create: yes
        validate: 'visudo -c -f %s'
:wq
sudo ansible-playbook playbook.yml -i inventory/

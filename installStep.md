1. `cd` into the folder where `Dockerfile` is.

2. Create a docker ubuntu system image for installing SU2: `docker build -t su2 .` (`-t` to specify image name as `su2`, and `.` means using the `Dockerfile` in this folder)

3. Create a docker image for installing SU2 by executing `./create_su2_container.sh`

4. Create a docker container for installing SU2 by executing `./start_su2.sh`

5. Now, you should be in docker container, and the current path in docker container should correspond to `test` folder in your host system. Run `ls`, you can see two files: `Miniconda3-latest-Linux-x86_64.sh` and `su2code-SU2-v7.3.1-0-g328a1b7.tar.gz`.

6. Install `Miniconda3` by `bash Miniconda3-latest-Linux-x86_64.sh`. Set `yes` to all install options.

7. Put `export OMPI_MCA_btl_vader_single_copy_mechanism=none` into `.bashrc` (See [this issue](https://github.com/open-mpi/ompi/issues/4948))

8. Create a vistual environment for installing SU2: `conda create -n su2 numpy python=3.7` (`numpy` is needed by `parallel_computation.py`)

9. Install `mpi4py` by `python -m pip install mpi4py --user`. **Warning**: DO NOT use `conda install mpi4py`. See [this discussion](https://github.com/su2code/SU2/discussions/1689)

10. Uncompress `su2code-SU2-v7.3.1-0-g328a1b7.tar.gz` by `tar zxvf su2code-SU2-v7.3.1-0-g328a1b7.tar.gz`. Rename the code folder to `su2code`, and then `cd su2code`.

11. **Important**: change the `static: true` argument to `static: false` in `externals/cgns/hdf5/meson.build`. See [this issue](https://github.com/su2code/SU2/issues/1568#issuecomment-1083104460)

12. Install `SU2` following the [guidance](https://su2code.github.io/docs_v7/Build-SU2-Linux-MacOS/):

    Firstly, executing
    ```
    ./meson.py build -Denable-autodiff=true -Denable-directdiff=true -Denable-pywrapper=true -Dwith-mpi=enabled --prefix=/home/tang/SU2
    ```
    Then put the suggested path (see the terminal outputs) into your `.bashrc`.

    Then executing
    ```
    ./ninja -C build install
    ```

`SU2` should be installed successfully now.
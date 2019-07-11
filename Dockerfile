FROM jupyter/scipy-notebook:d4cbf2f80a2a

# install boto3, jupyter extensions and cx-oracle as jovyan
RUN conda install --quiet --yes 'boto3=1.9*' && \
    conda install --quiet --yes -v anaconda openpyxl=2.6.1 && \
    conda install --quiet --yes -c conda-forge tqdm && \
    conda install --quiet --yes -c conda-forge jupyter_contrib_nbextensions && \
    conda install --quiet --yes -c conda-forge jupyter_nbextensions_configurator && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    pip install cx-oracle==7.1

# Install oracle-instantclient as root
# adapted from SYNC docker-oracle-python Dockerfile: http://bitbucket.kobaltmusic.com:7990/projects/SYNC/repos/docker-python-oracle
ADD https://s3-eu-west-1.amazonaws.com/kobalt-web-oracle-driver-packages/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb /tmp
ADD https://s3-eu-west-1.amazonaws.com/kobalt-web-oracle-driver-packages/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb /tmp

USER root
RUN dpkg -i /tmp/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb /tmp/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb && \
    apt-get -y update && \
    apt-get -y install libaio1 && \
    apt-get purge -y perl perl5 && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /tmp/oracle-* && \
    rm -rf /usr/share/docs && \
    rm -rf /usr/share/man && \
    export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH} && \
    ldconfig

ENV ORACLE_HOME=/usr/lib/oracle/12.1/client64
ENV LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib/
RUN ldconfig && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable collapsible_headings/main --sys-prefix

# set user back to jovyan
USER $NB_UID

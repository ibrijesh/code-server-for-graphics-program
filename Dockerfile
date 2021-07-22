FROM ubuntu:xenial-20160331.1

COPY keyboard /etc/default/keyboard

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    ubuntu-desktop \
    gnome-panel \
    net-tools \
    curl \
    net-tools \
    metacity \
    bash \
    git \
    net-tools \
    novnc \
    supervisor \
    x11vnc \
    gnome-terminal \
    xterm \
    xvfb \
    htop \
    geany \
    nginx && \
    echo "tzdata tzdata/Areas select America" > ~/tx.txt && \
    echo "tzdata tzdata/Zones/America select New York" >> ~/tx.txt && \
    debconf-set-selections ~/tx.txt && \
    apt-get install -y --no-install-recommends \
    gnupg apt-transport-https \
    wget software-properties-common \
    ratpoison novnc websockify libxv1 \
    libglu1-mesa xauth x11-utils xorg tightvncserver \
    && apt-get autoclean \
    && apt-get autoremove 

RUN wget https://sourceforge.net/projects/virtualgl/files/2.6.5/virtualgl_2.6.5_amd64.deb && \
    wget https://sourceforge.net/projects/turbovnc/files/2.2.5/turbovnc_2.2.5_amd64.deb && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb	&& \
    dpkg -i virtualgl_*.deb && \
    dpkg -i turbovnc_*.deb

RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- |  apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" 
RUN apt-get update; \    
    apt-get install -y code --no-install-recommends



# Installing  C++ Graphics Required packages 

RUN apt-get -y update --fix-missing
RUN apt-get -y install wget \
    g++   build-essential  \
    software-properties-common apt-transport-https  \
    libsdl-image1.2 libsdl-image1.2-dev guile-1.8   \
    guile-1.8-dev libsdl1.2debian libart-2.0-dev libaudiofile-dev  \
    libesd0-dev libdirectfb-dev libdirectfb-extra libfreetype6-dev  \
    libxext-dev x11proto-xext-dev libfreetype6 libaa1 libaa1-dev  \
    libslang2-dev libasound2 libasound2-dev


RUN wget http://download.savannah.gnu.org/releases/libgraph/libgraph-1.0.2.tar.gz
RUN tar -xvzf libgraph-1.0.2.tar.gz
WORKDIR "/libgraph-1.0.2"
RUN ./configure
RUN make
RUN make install
RUN cp /usr/local/lib/libgraph.* /usr/lib   

RUN apt install vim -y

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=660 \
    RUN_XTERM=yes 

    

COPY . /app
WORKDIR /app/programs
RUN rm -f /etc/nginx/sites-enabled/default
COPY nginx/nginx.conf /etc/nginx/conf.d/nginx.conf
RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/conf.d/nginx-conf.sh
RUN chmod +x /app/entrypoint.sh




CMD ["/app/entrypoint.sh"]
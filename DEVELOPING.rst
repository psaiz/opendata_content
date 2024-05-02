============
 Developing
============

This module is an example of how the cernopendata-portal module could be used in two different use cases:

1. Using an existing release of that module to verify that new records could be registered
2. Modifying the core component of the cernopendata-portal

The first use case is recommended for curators and content managers. The main goal is to facilitate how to register data. Knowledge of yaml, and docker are required for this.
Sometimes, new data would require changes in the core system. For instance, if the new data defines new fields. On top of the previous knowledge, people going in this direction should be familiar with python, relational databases, search engines, javascript and css.

.. contents::
   :backlinks: none

Installation
============

A full explanation can be found in the developing guide of `cernopendata portal <https://github.com/cernopendata/cernopendata-portal/blob/main/DEVELOPING.rst>`_. For a quickstart guide, do the following:

.. code-block:: console

  $ # Checkout the module with the content
  $ git clone https://github.com/psaiz/opendata_content
  $ # Checkout the module with the portal
  $ git clone https://github.com/cernopendata/cernopendata-portal.git
  $ # Move to the directory of the content
  $ cd opendata_content
  $ # The command line is a bit long: let's create an alias to avoid typing all of that
  $ alias my_docker="docker compose -f ../cernopendata-portal/docker-compose.yml -f docker-compose.yaml"
  $ # Make sure that the latest images are available
  $ my_docker pull
  $ # Start the services
  $ my_docker up -d
  $ # Create the basic structure
  $ my_docker exec -it web /code/scripts/populate-instance.sh

..

At this point, all the services should be up and running. If you go to a web browser to http://0.0.0.0:5000/, you should see the web portal, with a few entries inside (the vocabularies, and news about the portal itself).

From this moment on,

Defining new entries
====================

This repository has the following data structure:

* data:
    * records: Put here the entries that should be inserted as records
    * docs: This folder will be for the documents
    * img: And this is for static images that might be needed
* scripts: Directory with shell scripts to help the development

If you want to modify the json schema, mappings or templates, you will find these folders in the `cernopendata portal <https://github.com/cernopendata/cernopendata-portal/>`_ repository

Working with docs/records
-------------------------

The recommended development process is the following:

1. Create the entries under data/(records/docs)
2. Validate that the yaml syntax is correct

.. code-block:: console

   $ my_docker exec -it web /content/scripts/check_fixtures.py

..

3. Load the entries in the system. To reload all the entries defined in this repo, do:

.. code-block:: console

   $ my_docker exec -it web /content/scripts/load-fixtures.sh

..

4. If you want to load only some records/docs

.. code-block:: console

   $ my_docker exec -it web cernopendata fixtures records --file /content/data/records/<full_path> --mode insert-or-update
   $ my_docker exec -it web cernopendata fixtures docs --file /content/data/docs/<full_path> --mode insert-or-update

..

5. Finally, if there are new images, ensure that they appear in the correct folder (THIS SCRIPT IS NOT READY YET)

.. code-block:: console

   $ my_docker exec -it web /data/scripts/load-images.sh

..



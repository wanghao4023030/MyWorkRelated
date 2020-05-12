# -*- coding : utf-8 -*-
import configparser
import sys
import os
from datetime import datetime
import shutil

#configuration_file_path = os.path.join(os.curdir,"config.ini")
configuration_file_path = "config.ini"
robot_cmd_string = "robot "

"""
Read the configuration files
"""

if os.path.exists(configuration_file_path):
    config = configparser.ConfigParser()
    config.read(configuration_file_path)
    sections = config.sections()
else:
    raise Exception("The configuration file is not exist! [%s] " % (configuration_file_path))

'''
Paramete the robot cmd string with configuration file
'''

try:
    if "tag" in sections:
        tagitem = config.get("tag", "tag")
        if tagitem.strip().lower() == "all":
            print("Execute all test cases")
        else:
            item_list = tagitem.split(",")
            for index in range(len(item_list)):
                robot_cmd_string = robot_cmd_string + " --include " + str(item_list[index])
    else:
        raise Exception("section tag is not in the configuration files [%s]" % configuration_file_path)

    if "outputdir" in sections:
        output_dir = config.get("outputdir", "outputdir")
        robot_cmd_string = robot_cmd_string + " -d " + str(output_dir)
    else:
        raise Exception("section outputdir is not in the configuration files [%s]" % configuration_file_path)

    if "logfilename" in sections:
        logfilename = config.get("logfilename", "logfilename")
        robot_cmd_string = robot_cmd_string + " -l " + str(logfilename)
    else:
        raise Exception("section logfilename is not in the configuration files [%s]" % configuration_file_path)

    if "reportfilename" in sections:
        reportfilename = config.get("reportfilename", "reportfilename")
        robot_cmd_string = robot_cmd_string + " -l " + str(reportfilename)
    else:
        raise Exception("section reportfilename is not in the configuration files [%s]" % configuration_file_path)

    if "outputTimeStamp" in sections:
        outputTimeStamp = config.get("outputTimeStamp", "outputTimeStamp")
        if outputTimeStamp.lower() == "true":
            robot_cmd_string = robot_cmd_string + " -T --timestampoutputs "
    else:
        raise Exception("section outputTimeStamp is not in the configuration files [%s]" % configuration_file_path)

    if "maxerrorlines" in sections:
        maxerrorlines = config.get("maxerrorlines", "maxerrorlines")

        if isinstance(maxerrorlines, str) and maxerrorlines == "NONE":
            robot_cmd_string = robot_cmd_string + " --maxerrorlines " + maxerrorlines
        else:
            raise Exception("The maxerrorlines parameter value is not correct, NONE is the correct one")

        if isinstance(maxerrorlines, int):
            if maxerrorlines >= 10 and maxerrorlines <= 40:
                robot_cmd_string = robot_cmd_string + " --maxerrorlines " + maxerrorlines
            else:
                raise Exception("You can set the parameter maxerrorlines with integer and the value should in [10,40]")

    else:
        raise Exception("section maxerrorlines is not in the configuration files [%s]" % configuration_file_path)

    loglevel_para = "TRACE:DEBUG:INFO:WARN:NONE"
    if "loglevel" in sections:
        loglevel = config.get("loglevel", "loglevel")
        robot_cmd_string = robot_cmd_string + " -L "

        if loglevel[-1] == ":":
            raise Exception("The loglevel parameter cannot end with [:], please change it and try again")

        if ":" not in loglevel:
            if loglevel in loglevel_para:
                robot_cmd_string = robot_cmd_string + loglevel + " "
            else:
                raise Exception(
                    "The logevel %s is not a parameter, please select one in %s ."
                    % (loglevel_list[index], loglevel_list))

        if ":" in loglevel:
            if loglevel in loglevel_para:
                robot_cmd_string = robot_cmd_string + loglevel
            else:
                loglevel_list = loglevel.split(":")
                for index in range(len(loglevel_list)):
                    if loglevel_list[index] not in loglevel_para:
                        raise Exception("The logevel [%s] is not a parameter, please select one in [%s]."
                                        % (loglevel_list[index], loglevel_para))

    else:
        raise Exception("section loglevel is not in the configuration files [%s]" % configuration_file_path)

    if "testsuite" in sections:
        testsuite = config.get("testsuite", "testsuite")
        if "," not in testsuite:
            if os.path.isfile(testsuite):
                if os.path.exists(testsuite):
                    if ".robot" in testsuite:
                        robot_cmd_string = robot_cmd_string + " " + testsuite
                    else:
                        raise Exception(
                            "The file type is not accepted, it should be robot file(.robot)! [%s]" % (testsuite))
                else:
                    raise Exception("The file is not exist! [%s]" % (testsuite))

            if os.path.isdir(testsuite):
                if os.path.exists(testsuite):
                    robot_cmd_string = robot_cmd_string + " " + testsuite
                else:
                    raise Exception("The folder is not exist! [%s]" % (testsuite))

        if "," in testsuite:
            testsuite_list = testsuite.split(",")
            if len(testsuite_list) <= 0:
                raise Exception("The file string is not correct, please use ',' to split multiple robot files.")

            else:
                for index in range(len(testsuite_list)):
                    testsuite_list[index] = str.strip(testsuite_list[index])
                    if os.path.isfile(testsuite_list[index]):
                        if os.path.exists(testsuite_list[index]):
                            if ".robot" in testsuite_list[index]:
                                robot_cmd_string = robot_cmd_string + " " + testsuite_list[index]
                            else:
                                raise Exception("The file type is not accepted, it should be robot file(.robot)! [%s]"
                                                % (testsuite_list[index]))
                        else:
                            raise Exception("The file is not exist! [%s]" % (testsuite_list[index]))

                    if os.path.isdir(testsuite_list[index]):
                        if os.path.exists(testsuite_list[index]) and os.path.isdir(testsuite_list[index]):
                            if os.path.exists(testsuite_list[index]):
                                robot_cmd_string = robot_cmd_string + " " + testsuite_list[index]
                            else:
                                raise Exception("The folder is not exist [%s]"
                                                % (testsuite_list[index]))
                        else:
                            raise Exception("The folder is not exist! [%s]" % (testsuite_list[index]))



    else:
        raise Exception("The testsuite is not exsit, the Runner cannnot executed. "
                        "Please in put the value for it.")
except:
    raise Exception("paramete the CMD string failed. Some tag cannot find or has error.")

try:
    print(robot_cmd_string)

    with open(output_dir +"\\runner_cmd.txt", "w") as file_object:

        file_object.write(robot_cmd_string)

    os.system(robot_cmd_string)
except:
    raise Exception("Execute cmd failed. [%s] " % (robot_cmd_string))

if "outputbackupdir" in sections:
    outputbackupdir = config.get("outputbackupdir", "outputbackupdir")
    if os.path.exists(outputbackupdir):
        temp_path = datetime.now().strftime("%Y_%m_%d")
        backup_path = os.path.join(outputbackupdir, temp_path)
        if os.path.exists(backup_path) == False:
            os.mkdir(backup_path)

        temp_path = datetime.now().strftime("%Y_%m_%d %H_%M_%S")
        backup_path = os.path.join(backup_path, temp_path)

        if os.path.exists(backup_path) == False:
            os.mkdir(backup_path)

        for filename in os.listdir(output_dir):
            shutil.copy(output_dir + filename, backup_path)
            print("Copy file " + filename + " to folder" + backup_path)

    else:
        raise Exception("The output backup folder is not exist: [%s]" % (outputbackupdir))
